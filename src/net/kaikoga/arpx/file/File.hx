package net.kaikoga.arpx.file;

import net.kaikoga.arpx.backends.flash.file.IFileFlashImpl;
import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("file", "null"))
class File
#if (arp_backend_flash || arp_backend_openfl) implements IFileFlashImpl #end
implements IArpObject {

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:IFileFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new () {
	}
}
