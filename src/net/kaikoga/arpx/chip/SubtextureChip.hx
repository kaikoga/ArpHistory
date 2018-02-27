package net.kaikoga.arpx.chip;

import net.kaikoga.arpx.texture.Texture;
import net.kaikoga.arp.structs.ArpParams;

@:arpType("chip", "subtexture")
class SubtextureChip extends Chip {

	private static var _workParams:ArpParams = new ArpParams();

	@:arpBarrier(true) @:arpField public var texture:Texture;

	public function new () {
		super();
	}
}


