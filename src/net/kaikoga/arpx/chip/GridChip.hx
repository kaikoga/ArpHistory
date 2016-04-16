package net.kaikoga.arpx.chip;

import net.kaikoga.arpx.texture.Texture;
import net.kaikoga.arp.structs.ArpParams;

#if flash
import net.kaikoga.arpx.backends.flash.chip.IChipFlashImpl;
import net.kaikoga.arpx.backends.flash.chip.GridChipFlashImpl;
#end

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("chip", "grid"))
class GridChip extends Chip {

	private static var _workParams:ArpParams = new ArpParams();

	@:arpValue public var baseX:Int;
	@:arpValue public var baseY:Int;
	@:arpValue public var chipWidth:Int;
	@:arpValue public var chipHeight:Int;

	@:arpValue public var dirs:Int = 1;
	@:arpBarrier @:arpType("texture") public var texture:Texture;
	//@:arpType("chipFaceList") public var chipFaceList:ChipFaceList;

	override public function chipWidthOf(params:ArpParams):Int {
		return (params != null) ? this.hasFace(params.get("face")) ? this.chipWidth : 0 : this.chipWidth;
	}

	override public function chipHeightOf(params:ArpParams):Int {
		return (params != null) ? this.hasFace(params.get("face")) ? this.chipHeight : 0 : this.chipHeight;
	}

	override public function hasFace(face:String):Bool {
		return true;
	}

	#if arp_backend_flash

	override private function createImpl():IChipFlashImpl return new GridChipFlashImpl(this);

	public function new() {
		super();
	}

	public function heatUp():Bool return cast(this.flashImpl, GridChipFlashImpl).heatUp();
	public function heatDown():Bool return cast(this.flashImpl, GridChipFlashImpl).heatDown();

	#else

	@:arpWithoutBackend
	public function new () {
		super();
	}

	#end
}


