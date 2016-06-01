package net.kaikoga.arpx.debugger;

import net.kaikoga.arp.domain.core.ArpSid;
import net.kaikoga.arp.domain.dump.ArpDomainDump;
import net.kaikoga.arp.persistable.DynamicPersistOutput;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.persistable.IPersistable;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
import net.kaikoga.arp.io.BlobInput;
import net.kaikoga.arp.events.ArpProgressEvent;
import net.kaikoga.arpx.socketClient.SocketClient;
import haxe.Json;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("debugger", "socketClient"))
class SocketClientDebugger implements IArpObject {

	@:arpField @:arpBarrier public var socketClient:SocketClient;
	private var blobInput:BlobInput;

	public function new() {
	}

	@:arpHeatUp
	private function heatUp():Bool {
		if (this.socketClient != null) {
			this.blobInput = new BlobInput(this.socketClient);
			this.blobInput.bigEndian = true;
			this.socketClient.onData.push(this.onSocketData);
		}
		return true;
	}

	private function onSocketData(event:ArpProgressEvent):Void {
		var arpType:String;
		var arpSlot:String;
		var json:String = null;
		while ((json = this.blobInput.nextUtfBlob()) != null) {
			trace("SocketClientDebugger.onSocketData(): " + json);
			var result:String = null;
			var command:Command = Json.parse(json);
			switch (command.command) {
				case "banks":
					result = Json.stringify({
						command: "banks",
						arpTypes: this.arpDomain().allArpTypes
					});
				case "bank":
					arpType = command.arpType;
					var obj:Dynamic = ArpDomainDump.anonPrinter.format(new ArpDomainDump(this.arpDomain(), function(value):Bool return value == arpType).dumpSlotStatusByName());
					result = Json.stringify({
						command : "bank",
						arpType : arpType,
						arpSlots : obj
					});
				case "slot":
					arpType = command.arpType;
					arpSlot = command.arpSlot;
					var object:Dynamic = null;
					var arpTemplateName:String = null;
					var slot:ArpUntypedSlot = this.arpDomain().getSlot(new ArpSid(arpSlot));
					var value:IPersistable = try cast(slot.value, IPersistable) catch (e:Dynamic) null;
					if (value != null) {
						var output:DynamicPersistOutput = new DynamicPersistOutput(null, -1);
						value.writeSelf(output);
						object = output.data;
						arpTemplateName = "slot.arpTemplateName";
					}
					else {
						object = { };
					}
					result = Json.stringify({
						command : "slot",
						arpType : arpType,
						arpSlot : arpSlot,
						arpTemplateName : arpTemplateName,
						object : object
					});
				default:
					break;
			}
			this.socketClient.writeUtfBlob(result);
		}
	}
}

private typedef Command = { command:String, ?arpType:String, ?arpSlot:String };
