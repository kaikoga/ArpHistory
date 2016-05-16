package net.kaikoga.arpx.shadow;

import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.chip.Chip;

#if flash
import net.kaikoga.arpx.backends.flash.shadow.ChipShadowFlashImpl;
import net.kaikoga.arpx.backends.flash.shadow.IShadowFlashImpl;
#end

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("shadow", "chip"))
class ChipShadow extends Shadow {

	@:arpField public var visible:Bool = true;
	@:arpField public var params:ArpParams;
	@:arpField public var position:ArpPosition;
	@:arpField public var mass:Float = 1.0;

	@:arpField public var chip:Chip;

	#if arp_backend_flash

	override private function createImpl():IShadowFlashImpl return new ChipShadowFlashImpl(this);

	public function new () {
		super();
	}

	#else

	@:arpWithoutBackend
	public function new () {
		super();
	}

	#end
}
