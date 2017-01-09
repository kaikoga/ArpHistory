package net.kaikoga.arpx.external;

import net.kaikoga.arp.seed.ArpSeedEnv;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.data.DataGroup;
import haxe.io.Bytes;
import net.kaikoga.arpx.file.File;
import net.kaikoga.arp.seed.ArpSeed;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("external", "file"))
class FileExternal extends External {

	@:arpField("file") @:arpBarrier public var file:File;

	private var data:DataGroup;
	private var env:ArpSeedEnv;

	public function new() {
		super();
	}

	// NOTE hack to acquire ArpSeedEnv
	override public function arpInit(slot:ArpUntypedSlot, seed:ArpSeed):IArpObject {
		this.env = seed.env();
	}

	@:arpHeatUp
	private function heatUp():Bool {
		this.load();
		return true;
	}

	@:arpHeatDown
	private function heatDown():Bool {
		this.unload();
		return true;
	}

	override public function load(force:Bool = false):Void {
		if (this.data != null && !force) {
			return;
		}
		var bytes:Bytes = this.file.bytes();
		if (bytes != null) {
			this.data = this.arpDomain.addObject(new DataGroup());
			this.data.add(this.arpDomain.loadSeed(ArpSeed.fromXmlBytes(bytes, env)));
		}
	}

	override public function unload():Void {
		if (this.data != null) {
			this.data.arpSlot.delReference();
			this.data = null;
		}
	}

}
