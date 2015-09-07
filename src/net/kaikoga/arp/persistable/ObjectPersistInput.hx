package net.kaikoga.arp.persistable;


import flash.utils.ByteArray;

class ObjectPersistInput implements IPersistInput {
	public var persistLevel(get, set):Int;


	private var _data:Dynamic;
	private var _keys:Array<Dynamic>;
	private var keyIndex:Int = 0;

	private var _persistLevel:Int = 0;

	private function get_PersistLevel():Int {
		return this._persistLevel;
	}

	private function set_PersistLevel(value:Int):Int {
		this._persistLevel = value;
		return value;
	}

	public function new(data:Dynamic, persistLevel:Int = 0) {
		super();
		this._data = data;
		this._keys = Reflect.field(data, "");
		this._persistLevel = persistLevel;
	}

	// TEST

	public function readName():String {
		if (!this._keys) {
			return null;
		}
		return this._keys[keyIndex++];
	}

	// TEST

	public function readPersistable(name:String, persistable:IPersistable):Void {
		persistable.readSelf(new ObjectPersistInput(this._data[name], this._persistLevel));
	}

	// TEST

	public function readBoolean(name:String):Bool {
		return this._data[name];
	}

	// TEST

	public function readInt(name:String):Int {
		return this._data[name];
	}

	// TEST

	public function readUnsignedInt(name:String):Int {
		return this._data[name];
	}

	// TEST

	public function readDouble(name:String):Float {
		return this._data[name];
	}

	// TEST

	public function readUTF(name:String):String {
		return this._data[name];
	}

	// TEST

	public function readBytes(name:String, bytes:ByteArray, offset:Int = 0, length:Int = 0):Void {
		var value:ByteArray = this._data[name];
		bytes.writeBytes(value, offset, length);
	}

	// TEST

	public function readBlob(name:String, bytes:ByteArray, offset:Int = 0):Void {
		this.readBytes(name, bytes, offset);
	}
}

