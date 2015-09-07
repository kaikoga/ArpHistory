package net.kaikoga.arp.persistable;


import haxe.io.Input;
import flash.utils.ByteArray;
import flash.utils.IDataInput;

class TaggedPersistInput implements IPersistInput {
	public var persistLevel(get, set):Int;


	private var _input:Input;

	private var _persistLevel:Int = 0;

	private function get_PersistLevel():Int {
		return this._persistLevel;
	}

	private function set_PersistLevel(value:Int):Int {
		this._persistLevel = value;
		return value;
	}

	public function new(input:IDataInput, persistLevel:Int = 0) {
		super();
		this._input = input;
		this._persistLevel = persistLevel;
	}

	// TEST

	public function readName():String {
		this._input.readUTF();
		return this._input.readUTF();
	}

	// TEST

	public function readPersistable(name:String, persistable:IPersistable):Void {
		var bytes:ByteArray = new ByteArray();
		this.readBlob(name, bytes);
		persistable.readSelf(new TaggedPersistInput(bytes, this._persistLevel));
	}

	// TEST

	public function readBoolean(name:String):Bool {
		this._input.readUTF();
		return this._input.readBoolean();
	}

	// TEST

	public function readInt(name:String):Int {
		this._input.readUTF();
		return this._input.readInt();
	}

	// TEST

	public function readUnsignedInt(name:String):Int {
		this._input.readUTF();
		return this._input.readUnsignedInt();
	}

	// TEST

	public function readDouble(name:String):Float {
		this._input.readUTF();
		return this._input.readDouble();
	}

	// TEST

	public function readUTF(name:String):String {
		this._input.readUTF();
		return this._input.readUTF();
	}

	// TEST

	public function readBytes(name:String, bytes:ByteArray, offset:Int = 0, length:Int = 0):Void {
		this._input.readUTF();
		this._input.readBytes(bytes, offset, length);
	}

	// TEST

	public function readBlob(name:String, bytes:ByteArray, offset:Int = 0):Void {
		this._input.readUTF();
		this._input.readBytes(bytes, offset, this._input.readInt());
	}
}

