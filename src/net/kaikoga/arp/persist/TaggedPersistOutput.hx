package net.kaikoga.arp.persistable;


import flash.utils.ByteArray;
import flash.utils.IDataOutput;

class TaggedPersistOutput implements IPersistOutput {
	public var persistLevel(get, set):Int;


	private var _output:IDataOutput;

	private var _persistLevel:Int = 0;

	private function get_PersistLevel():Int {
		return this._persistLevel;
	}

	private function set_PersistLevel(value:Int):Int {
		this._persistLevel = value;
		return value;
	}

	public function new(output:IDataOutput, persistLevel:Int = 0) {
		super();
		this._output = output;
		this._persistLevel = persistLevel;
	}

	// TEST

	public function writeName(value:String):Void {
		this._output.writeUTF("");
		this._output.writeUTF(value);
	}

	// TEST

	public function writePersistable(name:String, persistable:IPersistable):Void {
		var bytes:ByteArray = new ByteArray();
		persistable.writeSelf(new TaggedPersistOutput(bytes, this._persistLevel));
		this.writeBlob(name, bytes);
	}

	// TEST

	public function writeBoolean(name:String, value:Bool):Void {
		this._output.writeUTF(name);
		this._output.writeBoolean(value);
	}

	// TEST

	public function writeInt(name:String, value:Int):Void {
		this._output.writeUTF(name);
		this._output.writeInt(value);
	}

	// TEST

	public function writeUnsignedInt(name:String, value:Int):Void {
		this._output.writeUTF(name);
		this._output.writeUnsignedInt(value);
	}

	// TEST

	public function writeDouble(name:String, value:Float):Void {
		this._output.writeUTF(name);
		this._output.writeDouble(value);
	}

	// TEST

	public function writeUTF(name:String, value:String):Void {
		this._output.writeUTF(name);
		this._output.writeUTF(value);
	}

	// TEST

	public function writeBytes(name:String, bytes:ByteArray, offset:Int = 0, length:Int = 0):Void {
		this._output.writeUTF(name);
		this._output.writeBytes(bytes, offset, length);
	}

	// TEST

	public function writeBlob(name:String, bytes:ByteArray, offset:Int = 0, length:Int = 0):Void {
		length || = bytes.length - offset;
		this._output.writeUTF(name);
		this._output.writeInt(length);
		this._output.writeBytes(bytes, offset, length);
	}
}

