package arpx.chip.decorators;

import arpx.impl.cross.chip.decorators.TranslateChipImpl;
import arpx.impl.cross.geom.RectImpl;
import arpx.impl.cross.structs.ArpTransform;
import arpx.structs.ArpParams;

@:arpType("chip", "transform")
class TransformChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField public var transform:ArpTransform;

	@:arpImpl private var flashImpl:TranslateChipImpl;

	override public function layoutSize(params:ArpParams, rect:RectImpl):RectImpl {
		chip.layoutSize(params, rect);
		rect.transform(transform.impl);
		return rect;
	}

	public function new() super();
}
