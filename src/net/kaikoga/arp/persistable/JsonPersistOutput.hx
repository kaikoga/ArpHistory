package net.kaikoga.arp.persistable;

import haxe.crypto.Base64;
import haxe.io.Bytes;
import haxe.Json;

class JsonPersistOutput extends AnonPersistOutput {

	public var json(get, never):String;
	private function get_json():Dynamic return Json.stringify(this.data);

	public function new(persistLevel:Int = 0) {
		super(null, persistLevel);
	}

	override public function writePersistable(name:String, persistable:IPersistable):Void {
		var output:JsonPersistOutput = new JsonPersistOutput(this.persistLevel);
		persistable.writeSelf(output);
		Reflect.setField(this._data, name, output.data);
	}

	override public function writeBlob(name:String, bytes:Bytes):Void {
		Reflect.setField(this._data, name, Base64.encode(bytes));
	}
}

