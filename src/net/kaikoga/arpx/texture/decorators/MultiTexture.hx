package net.kaikoga.arpx.texture.decorators;

@:arpType("texture", "multi")
class MultiTexture extends Texture {
	@:arpBarrier(true) @:arpField public var texture:Texture;
	@:arpWithoutBackend
	public function new () {
		super();
	}
}
