package net.kaikoga.arpx.texture;

import net.kaikoga.arpx.structs.ArpColor;
import net.kaikoga.arpx.texture.decorators.MultiTexture;
import net.kaikoga.arpx.faceList.FaceList;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.impl.backends.flash.texture.NativeTextTextureFlashImpl;
#elseif arp_backend_heaps
import net.kaikoga.arpx.impl.backends.heaps.texture.NativeTextTextureHeapsImpl;
#end

@:arpType("texture", "nativeText")
class NativeTextTexture extends MultiTexture
{
	@:arpField public var font:String = "_sans";
	@:arpField public var fontSize:Int = 12;
	@:arpField public var color:ArpColor; // FIXME
	@:arpBarrier @:arpField public var faceList:FaceList;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:NativeTextTextureFlashImpl;
	#elseif arp_backend_heaps
	@:arpImpl private var heapsImpl:NativeTextTextureHeapsImpl;
	#end

	public function new() super();
}
