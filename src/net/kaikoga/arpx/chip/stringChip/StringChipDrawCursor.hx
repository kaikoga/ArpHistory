package net.kaikoga.arpx.chip.stringChip;

import net.kaikoga.arpx.structs.ArpParams;
import net.kaikoga.arpx.structs.IArpParamsRead;

class StringChipDrawCursor {

	private var initX:Float = 0;
	private var initY:Float = 0;
	public var x:Float = 0;
	public var y:Float = 0;
	private var nextX:Float = 0;
	private var nextY:Float = 0;
	private var params:ArpParamsProxy;

	public function new(x:Float, y:Float, params:IArpParamsRead) {
		this.initX = x;
		this.x = x;
		this.nextX = x;
		this.initY = y;
		this.y = y;
		this.nextY = y;
		this.params = new ArpParams().copyFrom(params);
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
						this.nextY = this.initY;
						this.nextX -= childChip.chipWidth;
						return null;
					default:
						this.params["face"] = char;
						this.x = this.nextX;
						this.y = this.nextY;
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
						this.nextX = this.initX;
						this.nextY -= childChip.chipHeight;
						return null;
					default:
						this.params["face"] = char;
						this.x = this.nextX;
						this.y = this.nextY;
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
						this.nextY = this.initY;
						this.nextX += childChip.chipWidth;
						return null;
					default:
						this.params["face"] = char;
						this.x = this.nextX;
						this.y = this.nextY;
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
						this.nextX = this.initX;
						this.nextY += childChip.chipHeight;
						return null;
					default:
						this.params["face"] = char;
						this.x = this.nextX;
						this.y = this.nextY;
						this.nextX += (chip.isProportional) ? childChip.chipWidthOf(this.params) : childChip.chipWidth;
						return this.params;
				}
		}
	}
}

