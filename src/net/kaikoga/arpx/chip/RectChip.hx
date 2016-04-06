package net.kaikoga.arpx.chip;

import net.kaikoga.arp.structs.ArpColor;
import net.kaikoga.arp.structs.ArpParams;

#if flash
import net.kaikoga.arpx.backends.flash.chip.IChipFlashImpl;
import net.kaikoga.arpx.backends.flash.chip.RectChipFlashImpl;
#end

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.buildDerived("chip", "rect"))
class RectChip extends Chip {

	@:arpValue public var baseX(get, set):Int;
	@:arpValue public var baseY(get, set):Int;
	@:arpValue public var chipWidth(get, set):Int;
	@:arpValue public var chipHeight(get, set):Int;
	@:arpValue public var color(get, set):ArpColor;
	@:arpValue public var border(get, set):ArpColor;

	override public function chipWidthOf(params:ArpParams):Int {
		return this.chipWidth;
	}

	override public function chipHeightOf(params:ArpParams):Int {
		return this.chipHeight;
	}

	override public function hasFace(face:String):Bool {
		return true;
	}

	#if arp_backend_flash

	override private function createImpl():IChipFlashImpl return new RectChipFlashImpl(this);

	public function new() {
		super();
	}

	#else

	@:arpWithoutBackend
	public function new () {
		super();
	}

	#end
}
