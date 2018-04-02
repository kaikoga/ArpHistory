package net.kaikoga.arpx.storage;

#if (flash || arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.storage.LocalStorageFlashImpl;
#end

@:arpType("storage", "local")
class LocalStorage extends Storage {

	@:arpField public var src:String;

#if (flash || arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:LocalStorageFlashImpl;
#end

	public function new () {
		super();
	}
}
