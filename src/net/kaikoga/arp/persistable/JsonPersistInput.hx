package net.kaikoga.arp.persistable;

import haxe.crypto.Base64;
import haxe.io.Bytes;
import haxe.Json;

class JsonPersistInput extends JsonPersistInputBase {

	public function new(data:String, persistLevel:Int = 0) {
		super(Json.parse(data), persistLevel);
	}
}

private class JsonPersistInputBase extends AnonPersistInput {

	private function new(data:Dynamic, persistLevel:Int = 0) {
		super(data, persistLevel);
	}

	override public function readEnter(name:String):IPersistInput return new JsonPersistInputBase(Reflect.field(this._data, name), this._persistLevel);

	override public function readBlob(name:String):Bytes {
		return Base64.decode(Reflect.field(this._data, name));
	}
}

