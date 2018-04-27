package net.kaikoga.arpx.texture.decorators;

import net.kaikoga.arpx.faceList.FaceList;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.texture.decorators.GridTextureFlashImpl;
#elseif arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.texture.decorators.GridTextureHeapsImpl;
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
	#elseif arp_backend_heaps
	@:arpImpl private var heapsImpl:GridTextureHeapsImpl;
	#end

	public function new() super();
}
