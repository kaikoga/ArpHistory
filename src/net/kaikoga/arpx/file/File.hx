package net.kaikoga.arpx.file;

import net.kaikoga.arp.domain.IArpObject;

#if (flash || arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.file.IFileFlashImpl;
#end

@:arpType("file", "null")
class File
#if (flash || arp_backend_flash || arp_backend_openfl) implements IFileFlashImpl #end
implements IArpObject {

#if (flash || arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:IFileFlashImpl;
#end

	public function new () {
	}
}
