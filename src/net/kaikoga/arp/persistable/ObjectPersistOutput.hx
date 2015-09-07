package net.kaikoga.arp.persistable;


import flash.utils.ByteArray;

class ObjectPersistOutput implements IPersistOutput {
	public var data(get, never):Dynamic;
	public var persistLevel(get, set):Int;


	private var _data:Dynamic;

	private function get_Data():Dynamic {
		return this._data;
	}

	private var _persistLevel:Int = 0;

	private function get_PersistLevel():Int {
		return this._persistLevel;
	}

	private function set_PersistLevel(value:Int):Int {
		this._persistLevel = value;
		return value;
	}

	public function new(data:Dynamic = null, persistLevel:Int = 0) {
		super();
		this._data = data || { };
		this._persistLevel = persistLevel;
	}

	// TEST

	public function writeName(value:String):Void {
		var keys:Array<Dynamic> = this._data[""] || = [];
		keys.push(value);
	}

	// TEST

	public function writePersistable(name:String, persistable:IPersistable):Void {
		var output:ObjectPersistOutput = new ObjectPersistOutput(null, this._persistLevel);
		persistable.writeSelf(output);
		this._data[name] = output.data;
	}

	// TEST

	public function writeBoolean(name:String, value:Bool):Void {
		this._data[name] = value;
	}

	// TEST

	public function writeInt(name:String, value:Int):Void {
		this._data[name] = value;
	}

	// TEST

	public function writeUnsignedInt(name:String, value:Int):Void {
		this._data[name] = value;
	}

	// TEST

	public function writeDouble(name:String, value:Float):Void {
		this._data[name] = value;
	}

	// TEST

	public function writeUTF(name:String, value:String):Void {
		this._data[name] = value;
	}

	// TEST

	public function writeBytes(name:String, bytes:ByteArray, offset:Int = 0, length:Int = 0):Void {
		var value:ByteArray = new ByteArray();
		value.writeBytes(bytes, offset, length);
		this._data[name] = value;
	}

	// TEST

	public function writeBlob(name:String, bytes:ByteArray, offset:Int = 0, length:Int = 0):Void {
		this.writeBytes(name, bytes, offset, length);
	}
}

