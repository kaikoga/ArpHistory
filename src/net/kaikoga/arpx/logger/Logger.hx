package net.kaikoga.arpx.logger;

import net.kaikoga.arp.domain.events.ArpLogEvent;
import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("logger", "null"))
class Logger implements IArpObject {

	@:arpField("category") public var categories:Array<String>;

	public function new() {
	}

	@:arpHeatUp private function heatUp():Bool {
		this.arpDomain().onLog.push(this.log);
		return true;
	}

	@:arpHeatDown private function heatDown():Bool {
		this.arpDomain().onLog.remove(this.log);
		return true;
	}

	public function log(event:ArpLogEvent):Void {
	}

	public function respondsTo(category:String):Bool {
		return category == "*" || this.categories.indexOf(category) >= 0 || this.categories.indexOf("*") >= 0;
	}
}


