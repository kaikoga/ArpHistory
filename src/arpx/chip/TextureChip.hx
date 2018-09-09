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
		return if (params == null) this.chipWidth else this.texture.widthOf(params);
	}

	override public function chipHeightOf(params:ArpParams):Int {
		return if (params == null) this.chipHeight else this.texture.heightOf(params);
	}

	override public function hasFace(face:String):Bool return true;

	@:arpImpl private var arpImpl:TextureChipImpl;

	public function new() super();
}


