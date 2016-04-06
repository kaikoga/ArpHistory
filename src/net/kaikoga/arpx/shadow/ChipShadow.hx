package net.kaikoga.arpx.shadow;

import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.chip.Chip;

#if flash
import net.kaikoga.arpx.backends.flash.shadow.ChipShadowFlashImpl;
import net.kaikoga.arpx.backends.flash.shadow.IShadowFlashImpl;
#end

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.buildDerived("shadow", "chip"))
class ChipShadow extends Shadow {

	@:arpValue public var visible:Bool = true;
	@:arpValue public var params:ArpParams;
	@:arpValue public var position:ArpPosition;
	@:arpValue public var mass:Float = 1.0;

	@:arpType("chip") public var chip:Chip;

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
