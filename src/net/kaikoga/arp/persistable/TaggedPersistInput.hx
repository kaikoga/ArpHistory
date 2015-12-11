package net.kaikoga.arp.persistable;

import net.kaikoga.arp.io.InputWrapper;
import haxe.io.BytesInput;
import haxe.io.Bytes;
import net.kaikoga.arp.io.IInput;

class TaggedPersistInput implements IPersistInput {

	private var _input:IInput;

	private var _persistLevel:Int = 0;
	public var persistLevel(get, never):Int;
	private function get_persistLevel():Int return this._persistLevel;

	public function new(input:IInput, persistLevel:Int = 0) {
		this._input = input;
		this._persistLevel = persistLevel;
	}

	public function readName():String {
		this._input.readUtfBlob();
		return this._input.readUtfBlob();
	}

	public function readNameList(name:String):Array<String> {
		this._input.readUtfBlob();
		var nameList:Array<String> = [];
		for (i in 0...this._input.readUInt32()) nameList.push(this._input.readUtfBlob());
		return nameList;
	}

	public function readPersistable(name:String, persistable:IPersistable):Void {
		var bytes:Bytes = this.readBlob(name);
		persistable.readSelf(new TaggedPersistInput(new InputWrapper(new BytesInput(bytes)), this._persistLevel));
	}

	public function readBool(name:String):Bool {
		this._input.readUtfBlob();
		return this._input.readBool();
	}

	public function readInt32(name:String):Int {
		this._input.readUtfBlob();
		return this._input.readInt32();
	}

	public function readUInt32(name:String):Int {
		this._input.readUtfBlob();
		return this._input.readUInt32();
	}

	public function readDouble(name:String):Float {
		this._input.readUtfBlob();
		return this._input.readDouble();
	}

	public function readUtf(name:String):String {
		this._input.readUtfBlob();
		return this._input.readUtfBlob();
	}

	public function readBlob(name:String):Bytes {
		this._input.readUtfBlob();
		return this._input.readBlob();
	}
}

