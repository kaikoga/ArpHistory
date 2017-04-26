package net.kaikoga.arpx.file;

import net.kaikoga.arpx.backends.flash.file.ResourceFileFlashImpl;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("file", "resource"))
class ResourceFile extends File {

	@:arpField public var src:String;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:ResourceFileFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new () {
		super();
	}
}
