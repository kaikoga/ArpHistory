package net.kaikoga.arpx.file;

import net.kaikoga.arpx.backends.flash.file.IFileFlashImpl;
import net.kaikoga.arp.domain.IArpObject;

@:arpType("file", "null")
class File
#if (arp_backend_flash || arp_backend_openfl) implements IFileFlashImpl #end
implements IArpObject {

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:IFileFlashImpl;
#end

	public function new () {
	}
}
