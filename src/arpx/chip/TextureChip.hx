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

	override private function get_chipWidth():Float return this.texture.width;
	override private function get_chipHeight():Float return this.texture.height;

	override public function chipWidthOf(params:ArpParams):Float {
		return if (params == null) this.chipWidth else this.texture.widthOf(params);
	}

	override public function chipHeightOf(params:ArpParams):Float {
		return if (params == null) this.chipHeight else this.texture.heightOf(params);
	}

	@:arpImpl private var arpImpl:TextureChipImpl;

	public function new() super();
}


