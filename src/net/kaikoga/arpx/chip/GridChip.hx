package net.kaikoga.arpx.chip;

import net.kaikoga.arpx.faceList.FaceList;
import net.kaikoga.arp.structs.ArpParams;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.chip.GridChipFlashImpl;
#end

@:arpType("chip", "grid")
class GridChip extends SubtextureChip {

	@:arpField public var baseX:Int;
	@:arpField public var baseY:Int;
	@:arpField public var chipWidth:Int;
	@:arpField public var chipHeight:Int;

	@:arpBarrier(true) @:arpField public var faceList:FaceList;
	@:arpField public var dirs:Int = 1;
	@:arpField public var offset:Int = 0;

	override public function chipWidthOf(params:ArpParams):Int {
		return (params != null) ? this.hasFace(params.get("face")) ? this.chipWidth : 0 : this.chipWidth;
	}

	override public function chipHeightOf(params:ArpParams):Int {
		return (params != null) ? this.hasFace(params.get("face")) ? this.chipHeight : 0 : this.chipHeight;
	}

	override public function hasFace(face:String):Bool {
		return true;
	}

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl
	private var flashImpl:GridChipFlashImpl;
#end

	public function new () {
		super();
	}
}


