package arpx.chip;

import arpx.impl.cross.chip.TextureChipImpl;
import arpx.structs.ArpColor;
import arpx.structs.ArpParams;
import arpx.texture.Texture;

@:arpType("chip", "texture")
class TextureChip extends Chip {

	@:arpBarrier(true) @:arpField public var texture:Texture;
	@:arpField public var color:ArpColor = new ArpColor(0xffffffff);
	@:arpField public var baseX:Int;
	@:arpField public var baseY:Int;

	override private function get_chipWidth():Int return this.texture.width;
	override private function get_chipHeight():Int return this.texture.height;

	override public function chipWidthOf(params:ArpParams):Int {
		return (params != null) ? this.hasFace(params.get("face")) ? this.chipWidth : 0 : this.chipWidth;
	}

	override public function chipHeightOf(params:ArpParams):Int {
		return (params != null) ? this.hasFace(params.get("face")) ? this.chipHeight : 0 : this.chipHeight;
	}

	override public function hasFace(face:String):Bool return true;

	@:arpImpl private var arpImpl:TextureChipImpl;

	public function new() super();
}


