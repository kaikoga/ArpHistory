package net.kaikoga.arpx.chip;

import net.kaikoga.arpx.backends.flash.geom.ITransform;
import flash.display.BitmapData;
import net.kaikoga.arpx.backends.flash.chip.StringChipFlashImpl;
import net.kaikoga.arpx.shadow.ChipShadow;
import net.kaikoga.arpx.shadow.IShadow;
import net.kaikoga.arpx.chip.stringChip.StringChipStringIterator;
import net.kaikoga.arp.structs.ArpParams;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("chip", "string"))
class StringChip implements IChip
{

	private static var _workParams:ArpParams = new ArpParams();

	@:arpValue public var baseX:Int;
	@:arpValue public var baseY:Int;

	@:isVar public var chipWidth(get, set):Int;
	private function get_chipWidth():Int return this.chipWidth;
	private function set_chipWidth(value:Int) return this.chipWidth = value;
	@:isVar public var chipHeight(get, set):Int;
	private function get_chipHeight():Int return this.chipHeight;
	private function set_chipHeight(value:Int) return this.chipHeight = value;

	@:arpValue public var isProportional:Bool;
	@:arpValue public var orientation:Int;

	@:arpType("chip") public var chip:IChip;

	public function chipWidthOf(params:ArpParams):Int {
		if (params == null) {
			return 0;
		}
		var chip:IChip = this.chip;
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

	public function chipHeightOf(params:ArpParams):Int {
		if (params == null) {
			return 0;
		}
		var chip:IChip = this.chip;
		params = _workParams.copyFrom(params);
		var result:Int = this.chip.chipHeight;
		for (char in new StringChipStringIterator(params.get("face"))) {
			if (char == "\n") result += this.chip.chipHeight;
		}
		return result;
	}

	public function hasFace(face:String):Bool {
		return true;
	}

	public function toShadow(params:ArpParams = null):IShadow {
		var shadow:ChipShadow = this.arpDomain().allocObject(ChipShadow);
		shadow.chip = this;
		shadow.params = params;
		return shadow;
	}

	#if arp_backend_flash

	public function new() {
		flashImpl = new StringChipFlashImpl(this);
	}

	private var flashImpl:StringChipFlashImpl;

	inline public function copyChip(bitmapData:BitmapData, transform:ITransform, params:ArpParams = null):Void {
		flashImpl.copyChip(bitmapData, transform, params);
	}

	#end
}


