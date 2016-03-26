package net.kaikoga.arpx.chip;

import net.kaikoga.arp.structs.ArpColor;
import net.kaikoga.arpx.backends.flash.chip.NativeTextChipFlashImpl;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import flash.display.BitmapData;
import net.kaikoga.arpx.shadow.ChipShadow;
import net.kaikoga.arpx.shadow.IShadow;
import net.kaikoga.arp.structs.ArpParams;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("chip", "nativeText"))
class NativeTextChip implements IChip {

	@:arpValue public var baseX:Int;
	@:arpValue public var baseY:Int;
	@:arpValue public var chipWidth:Int;
	@:arpValue public var chipHeight:Int;

	@:arpValue public var font:String;
	@:arpValue public var fontSize:Int = 12;
	@:arpValue public var color:ArpColor;

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

	#end
}


