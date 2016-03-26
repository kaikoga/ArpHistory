package net.kaikoga.arpx.chip;

import net.kaikoga.arp.structs.ArpColor;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.shadow.IShadow;
import net.kaikoga.arpx.shadow.ChipShadow;

#if flash
import net.kaikoga.arpx.backends.flash.chip.IChipFlashImpl;
import net.kaikoga.arpx.backends.flash.chip.RectChipFlashImpl;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import flash.display.BitmapData;
#end

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("chip", "rect"))
class RectChip implements IChip
#if arp_backend_flash implements IChipFlashImpl #end
{

	@:arpValue public var baseX(get, set):Int;
	@:arpValue public var baseY(get, set):Int;
	@:arpValue public var chipWidth(get, set):Int;
	@:arpValue public var chipHeight(get, set):Int;
	@:arpValue public var color(get, set):ArpColor;
	@:arpValue public var border(get, set):ArpColor;

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

	#else

	public function new () {
	}

	#end
}
