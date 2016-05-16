package net.kaikoga.arpx.file;

import net.kaikoga.arpx.backends.flash.file.ResourceFileFlashImpl;
import net.kaikoga.arpx.backends.flash.file.IFileFlashImpl;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("file", "resource"))
class ResourceFile extends File {

	@:arpField public var src:String;

	#if arp_backend_flash

	override private function createImpl():IFileFlashImpl return new ResourceFileFlashImpl(this);

	public function new() {
		super();
	}

	#else

	@:arpWithoutBackend
	public function new () {
		super();
	}

	#end
}
