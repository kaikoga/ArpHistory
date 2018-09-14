package arpx.impl.cross.chip;

import arpx.chip.stringChip.StringChipDrawCursor;
import arpx.chip.stringChip.StringChipStringIterator;
import arpx.chip.StringChip;
import arpx.impl.cross.display.RenderContext;
import arpx.impl.cross.geom.PointImpl;
import arpx.impl.cross.geom.ArpTransform;
import arpx.impl.ArpObjectImplBase;
import arpx.structs.IArpParamsRead;

class StringChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:StringChip;

	public function new(chip:StringChip) {
		super();
		this.chip = chip;
	}

	private var _workPt:PointImpl = new PointImpl();
	public function render(context:RenderContext, params:IArpParamsRead = null):Void {
		var pt:PointImpl = context.transform.toPoint(_workPt);
		var cursor:StringChipDrawCursor = new StringChipDrawCursor(pt.x, pt.y, params); // FIXME
		var transform:ArpTransform = context.dupTransform();
		for (char in new StringChipStringIterator(params.get("face"))) {
			params = cursor.move(char, this.chip, this.chip.chip);
			if (params != null) {
				transform.setXY(cursor.x, cursor.y);
				this.chip.chip.render(context, params);
			}
		}
		context.popTransform();
	}
}
