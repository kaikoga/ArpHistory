package net.kaikoga.arpx.chip;

import net.kaikoga.arp.structs.ArpColor;
import net.kaikoga.arpx.shadow.ChipShadow;
import net.kaikoga.arpx.shadow.IShadow;
import net.kaikoga.arp.structs.ArpParams;

#if flash
import net.kaikoga.arpx.backends.flash.chip.IChipFlashImpl;
import net.kaikoga.arpx.backends.flash.chip.NativeTextChipFlashImpl;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import flash.display.BitmapData;
#end

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("chip", "nativeText"))
class NativeTextChip implements IChip
#if arp_backend_flash implements IChipFlashImpl #end
{

	@:arpValue public var baseX:Int = 0;
	@:arpValue public var baseY:Int = 0;
	@:arpValue public var chipWidth:Int = 100;
	@:arpValue public var chipHeight:Int = 100;

	@:arpValue public var font:String = "_sans";
	@:arpValue public var fontSize:Int = 12;
	@:arpValue public var color:ArpColor = new ArpColor(0xff000000);

	public function chipWidthOf(params:ArpParams):Int return this.chipWidth;
	public function chipHeightOf(params:ArpParams):Int return this.chipHeight;
	public function hasFace(face:String):Bool return true;

	public function toShadow(params:ArpParams = null):IShadow {
		var shadow:ChipShadow = this.arpDomain().allocObject(ChipShadow);
		shadow.chip = this;
		shadow.params = params;
		return shadow;
	}

	#if arp_backend_flash

	public function new() {
		flashImpl = new NativeTextChipFlashImpl(this);
	}

	public function heatUp():Bool return this.flashImpl.heatUp();
	public function heatDown():Bool return this.flashImpl.heatDown();

	private var flashImpl:NativeTextChipFlashImpl;

	inline public function copyChip(bitmapData:BitmapData, transform:ITransform, params:ArpParams = null):Void {
		flashImpl.copyChip(bitmapData, transform, params);
	}

	#else

	@:arpWithoutBackend
	public function new () {
	}

	#end
}


