package arpx.chip.stringChip;

import arpx.impl.cross.geom.RectImpl;
import arpx.impl.cross.display.RenderContext;
import arpx.structs.ArpParams;
import arpx.structs.IArpParamsRead;
import arpx.structs.params.ArpParamsProxy;

class StringChipCursor {

	public var params(default, null):ArpParamsProxy;

	private var chip:StringChip;
	private var childChip:Chip;
	private var childChipSize:RectImpl;

	private var x:Float = 0;
	private var y:Float = 0;
	private var nextX:Float = 0;
	private var nextY:Float = 0;

	public function new(chip:StringChip, params:IArpParamsRead = null) {
		this.chip = chip;
		this.childChip = chip.chip;
		this.childChipSize = RectImpl.alloc();
		this.childChipSize = RectImpl.alloc();
		this.params = new ArpParams().copyFrom(params);
	}

	inline public function renderChar(context:RenderContext):Void {
		context.dupTransform();
		context.transform.prependXY(this.x, this.y);
		this.childChip.render(context, this.params);
		context.popTransform();
	}

	inline public function layoutChar(rect:RectImpl):RectImpl {
		rect.copyFrom(this.childChipSize);
		rect.translateXY(this.x, this.y);
		return rect;
	}

	public function move(char:String):Bool {
		this.params["face"] = char;
		this.x = this.nextX;
		this.y = this.nextY;

		this.childChip.layoutSize(this.params, this.childChipSize);

		switch (char) {
			case "/space/":
				this.nextX += childChipSize.width;
				return false;
			case "\t":
				this.nextX += childChipSize.width * 4;
				return false;
			case "\n":
				this.nextX = 0;
				this.nextY += childChipSize.height;
				return false;
			default:
				this.nextX += childChipSize.width;
				return true;
		}
	}

	public function cleanup():Void return;
}

