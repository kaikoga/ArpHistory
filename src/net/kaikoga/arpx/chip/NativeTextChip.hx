package net.kaikoga.arpx.chip;

import net.kaikoga.arp.structs.ArpColor;
import net.kaikoga.arp.structs.ArpParams;

#if flash
import net.kaikoga.arpx.backends.flash.chip.IChipFlashImpl;
import net.kaikoga.arpx.backends.flash.chip.NativeTextChipFlashImpl;
#end

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("chip", "nativeText"))
class NativeTextChip extends Chip {

	@:arpValue public var baseX:Int = 0;
	@:arpValue public var baseY:Int = 0;
	@:arpValue public var chipWidth:Int = 100;
	@:arpValue public var chipHeight:Int = 100;

	@:arpValue public var font:String = "_sans";
	@:arpValue public var fontSize:Int = 12;
	@:arpValue public var color:ArpColor = new ArpColor(0xff000000);

	override public function chipWidthOf(params:ArpParams):Int return this.chipWidth;
	override public function chipHeightOf(params:ArpParams):Int return this.chipHeight;
	override public function hasFace(face:String):Bool return true;

	#if arp_backend_flash

	override private function createImpl():IChipFlashImpl return new NativeTextChipFlashImpl(this);

	public function new() {
		super();
	}

	public function heatUp():Bool return cast(this.flashImpl, NativeTextChipFlashImpl).heatUp();
	public function heatDown():Bool return cast(this.flashImpl, NativeTextChipFlashImpl).heatDown();

	#else

	@:arpWithoutBackend
	public function new () {
		super();
	}

	#end
}


