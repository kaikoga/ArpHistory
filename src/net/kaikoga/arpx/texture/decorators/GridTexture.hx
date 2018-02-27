package net.kaikoga.arpx.texture.decorators;

import net.kaikoga.arpx.faceList.FaceList;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.texture.decorators.GridTextureFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.texture.decorators.GridTextureKhaImpl;
#end

@:arpType("texture", "grid")
class GridTexture extends MultiTexture {

	@:arpField(readonly) public var width:Int;
	@:arpField(readonly) public var height:Int;

	@:arpBarrier(true) @:arpField public var faceList:FaceList;
	@:arpField public var dirs:Int = 1;
	@:arpField public var offset:Int = 0;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:GridTextureFlashImpl;
	#end

	#if arp_backend_kha
	@:arpImpl private var khaImpl:GridTextureKhaImpl;
	#end

	public function new() super();
}
