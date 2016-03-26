package net.kaikoga.arpx.shadow;

import net.kaikoga.arpx.backends.flash.geom.ITransform;
import flash.display.BitmapData;
import net.kaikoga.arpx.backends.flash.shadow.ChipShadowFlashImpl;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.chip.IChip;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("shadow", "chip"))
class ChipShadow implements IShadow {

	@:arpValue public var visible:Bool;
	@:arpValue public var params:ArpParams;
	@:arpValue public var position:ArpPosition;
	@:arpValue public var mass:Float;

	@:arpType("chip") public var chip:IChip;

	#if arp_backend_flash

	public function new() {
		flashImpl = new ChipShadowFlashImpl(this);
	}

	private var flashImpl:ChipShadowFlashImpl;

	inline public function copySelf(bitmapData:BitmapData, transform:ITransform):Void {
		flashImpl.copySelf(bitmapData, transform);
	}

	#end
}
