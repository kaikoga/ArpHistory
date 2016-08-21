package net.kaikoga.arpx.file;

import haxe.io.Bytes;
import net.kaikoga.arpx.backends.flash.file.IFileFlashImpl;
import net.kaikoga.arp.io.IInput;
import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("file", "null"))
class File implements IArpObject {

	#if arp_backend_flash

	private var flashImpl:IFileFlashImpl;

	private function createImpl():IFileFlashImpl return null;

	public var exists(get, never):Bool;
	private function get_exists():Bool return flashImpl.exists;

	public function new() {
		flashImpl = createImpl();
	}

	public function bytes():Bytes return flashImpl.bytes();
	public function read():IInput return flashImpl.read();

	#else

	@:arpWithoutBackend
	public function new () {
	}

	#end
}
