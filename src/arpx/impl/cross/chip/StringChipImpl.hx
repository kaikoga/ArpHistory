package arpx.impl.cross.chip;

import arpx.chip.stringChip.StringChipCursor;
import arpx.chip.stringChip.StringChipStringIterator;
import arpx.chip.StringChip;
import arpx.impl.cross.display.RenderContext;
import arpx.impl.cross.geom.PointImpl;
import arpx.impl.ArpObjectImplBase;
import arpx.structs.IArpParamsRead;

class StringChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:StringChip;

	public function new(chip:StringChip) {
		super();
		this.chip = chip;
	}

	private var _workPt:PointImpl = PointImpl.alloc();
	public function render(context:RenderContext, params:IArpParamsRead = null):Void {
		var cursor:StringChipCursor = new StringChipCursor(this.chip, params);
		for (char in new StringChipStringIterator(params.get("face"))) {
			if (cursor.move(char)) cursor.renderChar(context);
		}
	}
}
