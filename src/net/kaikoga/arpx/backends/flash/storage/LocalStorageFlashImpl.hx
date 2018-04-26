package net.kaikoga.arpx.backends.flash.storage;

#if (flash || arp_backend_flash || arp_backend_openfl)

import flash.utils.ByteArray;
import flash.net.SharedObject;
import haxe.io.Bytes;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.cross.storage.IStorageImpl;
import net.kaikoga.arpx.storage.LocalStorage;

class LocalStorageFlashImpl extends ArpObjectImplBase implements IStorageImpl {

	private var storage:LocalStorage;

	public function new(storage:LocalStorage) {
		super();
		this.storage = storage;
	}

	public var bytes(get, set):Null<Bytes>;
	private function get_bytes():Null<Bytes> {
		var byteArray:ByteArray = so.data.bytes;
		return if (byteArray != null) Bytes.ofData(byteArray) else null;
	}
	private function set_bytes(value:Null<Bytes>):Null<Bytes> {
		so.data.bytes = if (value != null) value.getData() else null;
		return value;
	}

	private var _so:SharedObject;
	private var so(get, never):SharedObject;
	private function get_so():SharedObject {
		return if (this._so != null) this._so else this._so =  SharedObject.getLocal(storage.src);
	}
}

#end