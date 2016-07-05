package net.kaikoga.arpx.chip;

import net.kaikoga.arpx.chip.stringChip.StringChipStringIterator;
import net.kaikoga.arp.structs.ArpParams;

#if flash
import net.kaikoga.arpx.backends.flash.chip.IChipFlashImpl;
import net.kaikoga.arpx.backends.flash.chip.StringChipFlashImpl;
#end

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("chip", "string"))
class StringChip extends Chip {

	private static var _workParams:ArpParams = new ArpParams();

	@:arpField public var baseX:Int;
	@:arpField public var baseY:Int;
	@:arpField public var chipWidth:Int;
	@:arpField public var chipHeight:Int;

	@:arpField public var isProportional:Bool;
	@:arpField public var orientation:Int;

	@:arpField public var chip:Chip;

	override public function chipWidthOf(params:ArpParams):Int {
		if (params == null) {
			return 0;
		}
		var chip:Chip = this.chip;
		params = _workParams.copyFrom(params);
		var width:Int = 0;
		var result:Int = 0;
		for (char in new StringChipStringIterator(params.get("face"))) {
			switch (char) {
				case "\t":
					width += this.chip.chipWidth * 4;
				case "\n":
					result = (result > width) ? result : width;
					width = 0;
				default:
					params.set("face", char);
					width += (this.isProportional) ? this.chip.chipWidthOf(params) : this.chip.chipWidth;
					break;
			}
		}
		return ((result > width)) ? result : width;
	}

	override public function chipHeightOf(params:ArpParams):Int {
		if (params == null) {
			return 0;
		}
		var chip:Chip = this.chip;
		params = _workParams.copyFrom(params);
		var result:Int = this.chip.chipHeight;
		for (char in new StringChipStringIterator(params.get("face"))) {
			if (char == "\n") result += this.chip.chipHeight;
		}
		return result;
	}

	override public function hasFace(face:String):Bool {
		return true;
	}

	#if arp_backend_flash

	override private function createImpl():IChipFlashImpl return new StringChipFlashImpl(this);

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

