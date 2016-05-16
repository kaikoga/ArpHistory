package net.kaikoga.arpx.chip;

import net.kaikoga.arp.structs.ArpColor;
import net.kaikoga.arp.structs.ArpParams;

#if flash
import net.kaikoga.arpx.backends.flash.chip.IChipFlashImpl;
import net.kaikoga.arpx.backends.flash.chip.RectChipFlashImpl;
#end

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("chip", "rect"))
class RectChip extends Chip {

	@:arpField public var baseX(get, set):Int;
	@:arpField public var baseY(get, set):Int;
	@:arpField public var chipWidth(get, set):Int;
	@:arpField public var chipHeight(get, set):Int;
	@:arpField public var color(get, set):ArpColor;
	@:arpField public var border(get, set):ArpColor;

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
