package net.kaikoga.arp.persistable;

import haxe.io.Bytes;

class AnonPersistInput implements IPersistInput {

	private var _data:Dynamic;

	private var _persistLevel:Int = 0;
	public var persistLevel(get, never):Int;
	private function get_persistLevel():Int return this._persistLevel;

	public function new(data:Dynamic, persistLevel:Int = 0) {
		this._data = data;
		this._persistLevel = persistLevel;
	}

	public function readNameList(name:String):Array<String> return Reflect.field(this._data, name);
	public function readPersistable(name:String, persistable:IPersistable):Void {
		persistable.readSelf(new AnonPersistInput(Reflect.field(this._data, name), this._persistLevel));
	}

	public function readBool(name:String):Bool return Reflect.field(this._data, name);
	public function readInt32(name:String):Int return Reflect.field(this._data, name);
	public function readUInt32(name:String):UInt return Reflect.field(this._data, name);
	public function readDouble(name:String):Float return Reflect.field(this._data, name);

	public function readUtf(name:String):String return Reflect.field(this._data, name);
	public function readBlob(name:String):Bytes return Reflect.field(this._data, name);
}

