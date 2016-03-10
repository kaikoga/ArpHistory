package net.kaikoga.arpx.chip;

import flash.display.BitmapData;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.backends.flash.chip.RectChipFlashImpl;
import net.kaikoga.arp.structs.ArpColor;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.shadow.IShadow;
import net.kaikoga.arpx.shadow.ChipShadow;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("chip", "rect"))
class RectChip implements IChip {

	@:arpValue @:isVar public var baseX(get, set):Int;
	inline private function get_baseX():Int return baseX;
	inline private function set_baseX(value:Int):Int return baseX = value;

	@:arpValue @:isVar public var baseY(get, set):Int;
	inline private function get_baseY():Int return baseX;
	inline private function set_baseY(value:Int):Int return baseY = value;

	@:arpValue @:isVar public var chipWidth(get, set):Int;
	inline private function get_chipWidth():Int return chipWidth;
	inline private function set_chipWidth(value:Int):Int return chipWidth = value;

	@:arpValue @:isVar public var chipHeight(get, set):Int;
	inline private function get_chipHeight():Int return chipHeight;
	inline private function set_chipHeight(value:Int):Int return chipHeight = value;

	@:arpValue @:isVar public var color(get, set):ArpColor;
	inline private function get_color():ArpColor return color;
	inline private function set_color(value:ArpColor):ArpColor return color = value;

	@:arpValue @:isVar public var border(get, set):ArpColor;
	inline private function get_border():ArpColor return border;
	inline private function set_border(value:ArpColor):ArpColor return border = value;

	public function chipWidthOf(params:ArpParams):Int {
		return this.chipWidth;
	}

	public function chipHeightOf(params:ArpParams):Int {
		return this.chipHeight;
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
		flashImpl = new RectChipFlashImpl(this);
	}

	private var flashImpl:RectChipFlashImpl;

	inline public function copyChip(bitmapData:BitmapData, transform:ITransform, params:ArpParams = null):Void {
		flashImpl.copyChip(bitmapData, transform, params);
	}

	#end
}
