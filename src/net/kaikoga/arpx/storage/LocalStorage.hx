package net.kaikoga.arpx.storage;

#if (flash || openfl)
import net.kaikoga.arpx.impl.targets.flash.storage.LocalStorageFlashImpl;
#end

@:arpType("storage", "local")
class LocalStorage extends Storage {

	@:arpField public var src:String;

#if (flash || openfl)
	@:arpImpl private var flashImpl:LocalStorageFlashImpl;
#end

	public function new() super();
}
