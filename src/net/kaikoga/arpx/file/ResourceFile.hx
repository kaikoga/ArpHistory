package net.kaikoga.arpx.file;

#if (flash || arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.file.ResourceFileFlashImpl;
#end

@:arpType("file", "resource")
class ResourceFile extends File {

	@:arpField public var src:String;

#if (flash || arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:ResourceFileFlashImpl;
#end

	public function new () {
		super();
	}
}
