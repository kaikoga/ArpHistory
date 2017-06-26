package net.kaikoga.arpx.chip;

import net.kaikoga.arp.structs.ArpColor;
import net.kaikoga.arp.structs.ArpParams;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.chip.NativeTextChipFlashImpl;
#end

@:arpType("chip", "nativeText")
class NativeTextChip extends Chip {

	@:arpField public var baseX:Int = 0;
	@:arpField public var baseY:Int = 0;
	@:arpField public var chipWidth:Int = 100;
	@:arpField public var chipHeight:Int = 100;

	@:arpField public var font:String = "_sans";
	@:arpField public var fontSize:Int = 12;
	@:arpField public var color:ArpColor = new ArpColor(0xff000000);

	override public function chipWidthOf(params:ArpParams):Int return this.chipWidth;
	override public function chipHeightOf(params:ArpParams):Int return this.chipHeight;
	override public function hasFace(face:String):Bool return true;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:NativeTextChipFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new () {
		super();
	}
}


