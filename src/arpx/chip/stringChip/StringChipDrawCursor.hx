package arpx.chip.stringChip;

import arpx.impl.cross.display.RenderContext;
import arpx.structs.ArpParams;
import arpx.structs.IArpParamsRead;

class StringChipDrawCursor {

	private var context:RenderContext;
	private var nextX:Float = 0;
	private var nextY:Float = 0;
	private var params:ArpParamsProxy;

	public function new(context:RenderContext, params:IArpParamsRead = null) {
		context.dupTransform();
		this.context = context;
		this.params = new ArpParams().copyFrom(params);
	}

	inline private function moveTransform():Void {
		this.context.popTransform();
		this.context.dupTransform();
		this.context.transform.prependXY(this.nextX, this.nextY);
	}

	public function move(char:String, chip:StringChip, childChip:Chip):ArpParams {
		switch (chip.orientation) {
			case 90:
				switch (char) {
					case "/space/":
						this.nextY += childChip.chipHeight;
						return null;
					case "\t":
						this.nextY += childChip.chipHeight * 4;
						return null;
					case "\n":
						this.nextY = 0;
						this.nextX -= childChip.chipWidth;
						return null;
					default:
						this.params["face"] = char;
						this.moveTransform();
						this.nextY += (chip.isProportional) ? childChip.chipHeightOf(this.params) : childChip.chipHeight;
						return this.params;
				}

			case 180:
				switch (char) {
					case "/space/":
						this.nextX -= childChip.chipWidth;
						return null;
					case "\t":
						this.nextX -= childChip.chipWidth * 4;
						return null;
					case "\n":
						this.nextX = 0;
						this.nextY -= childChip.chipHeight;
						return null;
					default:
						this.params["face"] = char;
						this.moveTransform();
						this.nextX -= (chip.isProportional) ? childChip.chipWidthOf(this.params) : childChip.chipWidth;
						return this.params;
				}

			case 270:
				switch (char) {
					case "/space/":
						this.nextY -= childChip.chipHeight;
						return null;
					case "\t":
						this.nextY -= childChip.chipHeight * 4;
						return null;
					case "\n":
						this.nextY = 0;
						this.nextX += childChip.chipWidth;
						return null;
					default:
						this.params["face"] = char;
						this.moveTransform();
						this.nextY -= (chip.isProportional) ? childChip.chipHeightOf(this.params) : childChip.chipHeight;
						return this.params;
				}

			//case 0:
			default:
				switch (char) {
					case "/space/":
						this.nextX += childChip.chipWidth;
						return null;
					case "\t":
						this.nextX += childChip.chipWidth * 4;
						return null;
					case "\n":
						this.nextX = 0;
						this.nextY += childChip.chipHeight;
						return null;
					default:
						this.params["face"] = char;
						this.moveTransform();
						this.nextX += (chip.isProportional) ? childChip.chipWidthOf(this.params) : childChip.chipWidth;
						return this.params;
				}
		}
	}

	public function cleanup():Void {
		context.popTransform();
	}
}

