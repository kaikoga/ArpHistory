package net.kaikoga.arpx.texture.decorators;

import net.kaikoga.arpx.faceList.FaceList;
import net.kaikoga.arpx.backends.flash.texture.decorators.GridTextureFlashImpl;

@:arpType("texture", "grid")
class GridTexture extends MultiTexture {

	@:arpField(readonly) public var width:Int;
	@:arpField(readonly) public var height:Int;

	@:arpBarrier(true) @:arpField public var faceList:FaceList;
	@:arpField public var dirs:Int = 1;
	@:arpField public var offset:Int = 0;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var impl:GridTextureFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new () {
		super();
	}
}
