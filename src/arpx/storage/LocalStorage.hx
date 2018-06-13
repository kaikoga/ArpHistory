package arpx.storage;

#if (arp_storage_backend_flash || arp_storage_backend_openfl)
import arpx.impl.targets.flash.storage.LocalStorageFlashImpl;
#end

@:arpType("storage", "local")
class LocalStorage extends Storage {

	@:arpField public var src:String;

	#if (arp_storage_backend_flash || arp_storage_backend_openfl)
	@:arpImpl private var flashImpl:LocalStorageFlashImpl;
	#end

	public function new() super();
}
