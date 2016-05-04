package net.kaikoga.arpx.external;

import haxe.io.Bytes;
import net.kaikoga.arpx.file.File;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("external", "file"))
class FileExternal extends External {

	@:arpField("file") @:arpBarrier public var file:File;
	private var loaded:Bool = false;

	public function new() {
		super();
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
		if (this.loaded && !force) {
			return;
		}
		var bytes:Bytes = this.file.bytes();
		if (bytes != null) {
			var slot:ArpUntypedSlot = this.arpDomain().loadSeed(ArpSeed.fromXmlBytes(bytes));
			this.loaded = true;
		}
	}

	override public function unload():Void {
		if (this.loaded = true) {
			// TODO release data
			this.loaded = false;
		}
	}

}
