package net.kaikoga.arpx.shadow;

import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.chip.IChip;

#if flash
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.backends.flash.shadow.IShadowFlashImpl;
import net.kaikoga.arpx.backends.flash.shadow.ChipShadowFlashImpl;
import flash.display.BitmapData;
#end

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("shadow", "chip"))
class ChipShadow implements IShadow
#if arp_backend_flash implements IShadowFlashImpl #end
{

	@:arpValue public var visible:Bool = true;
	@:arpValue public var params:ArpParams;
	@:arpValue public var position:ArpPosition;
	@:arpValue public var mass:Float = 1.0;

	@:arpType("chip") public var chip:IChip;

	#if arp_backend_flash

	public function new() {
		flashImpl = new ChipShadowFlashImpl(this);
	}

	private var flashImpl:ChipShadowFlashImpl;

	inline public function copySelf(bitmapData:BitmapData, transform:ITransform):Void {
		flashImpl.copySelf(bitmapData, transform);
	}

	#else

	public function new () {
	}

	#end
}
