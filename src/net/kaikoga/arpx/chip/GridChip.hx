package net.kaikoga.arpx.chip;

import net.kaikoga.arpx.faceList.FaceList;
import net.kaikoga.arpx.texture.Texture;
import net.kaikoga.arp.structs.ArpParams;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.chip.GridChipFlashImpl;
#end

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("chip", "grid"))
class GridChip extends Chip {

	private static var _workParams:ArpParams = new ArpParams();

	@:arpField public var baseX:Int;
	@:arpField public var baseY:Int;
	@:arpField public var chipWidth:Int;
	@:arpField public var chipHeight:Int;

	@:arpField public var dirs:Int = 1;
	@:arpBarrier @:arpField public var faceList:FaceList;
	@:arpBarrier @:arpField public var texture:Texture;

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

	@:arpHeatUp private function heatUp():Bool return cast(this.arpImpl, GridChipFlashImpl).heatUp();
	@:arpHeatDown private function heatDown():Bool return cast(this.arpImpl, GridChipFlashImpl).heatDown();
#else
	@:arpWithoutBackend
#end
	public function new () {
		super();
	}
}


