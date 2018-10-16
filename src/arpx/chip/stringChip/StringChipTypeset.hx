package arpx.chip.stringChip;

import arp.iterators.SimpleArrayIterator;
import arpx.impl.cross.geom.RectImpl;
import arpx.structs.ArpParams;
import arpx.structs.IArpParamsRead;

class StringChipTypeset {

	private var chip:StringChip;
	private var childChip:Chip;
	private var childChipSize:Map<String, RectImpl>;

	private var params:ArpParams;
	private var chars:Array<StringChipTypesetChar>;

	inline public function iterator():SimpleArrayIterator<StringChipTypesetChar> return new SimpleArrayIterator(chars);

	private function getChildFaceSize(char:String):RectImpl {
		if (childChipSize.exists(char)) {
			return childChipSize.get(char);
		} else {
			var rect:RectImpl = RectImpl.alloc();
			this.params.set("face", char);
			childChip.layoutSize(this.params, rect);
			childChipSize.set(char, rect);
			return rect;
		}
	}

	public function new(chip:StringChip, params:IArpParamsRead) {
		this.chip = chip;
		this.childChip = chip.chip;
		this.childChipSize = new Map<String, RectImpl>();
		this.params = new ArpParams().copyFrom(params);
		this.chars = [];

		var x:Float = 0;
		var y:Float = 0;
		for (char in new StringChipStringIterator(params.get("face"))) {
			this.params.set("face", char);
			var childFaceSize:RectImpl = getChildFaceSize(char);
			switch (char) {
				case "/space/":
					x += childFaceSize.width;
				case "\t":
					x += childFaceSize.width * 4;
				case "\n":
					x = 0;
					y += childFaceSize.height;
				default:
					if (chip.chipWidth > 0 && x + childFaceSize.width > chip.chipWidth) {
						x = 0;
						y += childFaceSize.height;
					}
					this.chars.push(new StringChipTypesetChar(this, x, y, char));
					x += childFaceSize.width;
			}
		}
	}

	public function match(chip:StringChip, params:IArpParamsRead):Bool {
		if (chip != this.chip) return false;
		if (params.get("face") != this.params.get("face")) return false;
		if (params.toString() != this.params.toString()) return false;
		return true;
	}

	inline public static function cached(chip:StringChip, params:IArpParamsRead):StringChipTypeset return StringChipTypesetCache.instance.get(chip, params);
}

