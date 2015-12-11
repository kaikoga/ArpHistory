package net.kaikoga.arp.persistable;

import haxe.io.Bytes;
import net.kaikoga.arp.io.IInput;

class PackedPersistInput implements IPersistInput {

	private var _input:IInput;

	public var persistLevel(get, never):Int;
	private var _persistLevel:Int = 0;
	private function get_persistLevel():Int return this._persistLevel;

	public function new(input:IInput, persistLevel:Int = 0) {
		this._input = input;
		this._persistLevel = persistLevel;
	}

	public function readName():String return this._input.readUtfBlob();
	public function readNameList(name:String):Array<String> {
		var nameList:Array<String> = [];
		for (i in 0...this._input.readUInt32()) nameList.push(this._input.readUtfBlob());
		return nameList;
	}
	public function readPersistable(name:String, persistable:IPersistable):Void persistable.readSelf(this);

	public function readBool(name:String):Bool return this._input.readBool();
	public function readInt32(name:String):Int return this._input.readInt32();
	public function readUInt32(name:String):Int return this._input.readUInt32();
	public function readDouble(name:String):Float return this._input.readDouble();

	public function readUtf(name:String):String return this._input.readUtfBlob();
	public function readBlob(name:String):Bytes return this._input.readBlob();
}

