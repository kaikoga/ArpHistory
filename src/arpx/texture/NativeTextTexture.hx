package arpx.texture;

import arpx.structs.ArpColor;
import arpx.texture.decorators.MultiTexture;
import arpx.faceList.FaceList;

#if (arp_display_backend_flash || arp_display_backend_openfl)
import arpx.impl.backends.flash.texture.NativeTextTextureFlashImpl;
#elseif arp_display_backend_heaps
import arpx.impl.backends.heaps.texture.NativeTextTextureHeapsImpl;
#end

@:arpType("texture", "nativeText")
class NativeTextTexture extends MultiTexture
{
	@:arpField public var font:String = "_sans";
	@:arpField public var fontSize:Int = 12;
	@:arpField public var color:ArpColor; // FIXME
	@:arpBarrier @:arpField public var faceList:FaceList;

	#if (arp_display_backend_flash || arp_display_backend_openfl)
	@:arpImpl private var flashImpl:NativeTextTextureFlashImpl;
	#elseif arp_display_backend_heaps
	@:arpImpl private var heapsImpl:NativeTextTextureHeapsImpl;
	#end

	public function new() super();
}
