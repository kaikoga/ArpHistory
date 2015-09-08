package net.kaikoga.arp.persistable;

import haxe.io.BytesOutput;
import haxe.io.Bytes;

class DynamicPersistOutput implements IPersistOutput {

	private var _data:Dynamic;
	public var data(get, never):Dynamic;
	private function get_data():Dynamic return this._data;
	private var _keys:Array<String>;

	private var _persistLevel:Int = 0;
	public var persistLevel(get, never):Int;
	private function get_persistLevel():Int return this._persistLevel;

	public function new(data:Dynamic = null, persistLevel:Int = 0) {
		this._data = (data != null) ? data : {};
		this._persistLevel = persistLevel;
	}

	public function writeName(value:String):Void {
		if (this._keys == null) {
			this._keys = [];
			Reflect.setField(this._data, "", this._keys);
		}
		this._keys.push(value);
	}
	public function writePersistable(name:String, persistable:IPersistable):Void {
		var output:DynamicPersistOutput = new DynamicPersistOutput(null, this._persistLevel);
		persistable.writeSelf(output);
		Reflect.setField(this._data, name, output.data);
	}

	public function writeBool(name:String, value:Bool):Void Reflect.setField(this._data, name, value);
	public function writeInt32(name:String, value:Int):Void Reflect.setField(this._data, name, value);
	public function writeUInt32(name:String, value:Int):Void Reflect.setField(this._data, name, value);
	public function writeDouble(name:String, value:Float):Void Reflect.setField(this._data, name, value);

	public function writeUtf(name:String, value:String):Void Reflect.setField(this._data, name, value);
	public function writeBlob(name:String, bytes:Bytes):Void Reflect.setField(this._data, name, bytes);
}

