package net.kaikoga.arpx.chip.decorators;

import net.kaikoga.arpx.backends.cross.chip.decorators.TranslateChipImpl;

@:arpType("chip", "translate")
class TranslateChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField public var a:Float = 1;
	@:arpField public var b:Float = 0;
	@:arpField public var c:Float = 0;
	@:arpField public var d:Float = 1;
	@:arpField public var x:Float = 0;
	@:arpField public var y:Float = 0;

	@:arpImpl private var flashImpl:TranslateChipImpl;

	public function new() super();
}
