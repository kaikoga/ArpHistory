package arpx.chip;

import arpx.structs.ArpColor;
import arpx.structs.ArpParams;
import arpx.texture.Texture;

#if (arp_display_backend_flash || arp_display_backend_openfl)
import arpx.impl.backends.flash.chip.TextureChipFlashImpl;
#elseif arp_display_backend_heaps
import arpx.impl.backends.heaps.chip.TextureChipHeapsImpl;
#end

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

	#if (arp_display_backend_flash || arp_display_backend_openfl)
	@:arpImpl private var flashImpl:TextureChipFlashImpl;
	#elseif arp_display_backend_heaps
	@:arpImpl private var heapsImpl:TextureChipHeapsImpl;
	#end

	public function new() super();
}


