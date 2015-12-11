package net.kaikoga.arp.persistable;

import net.kaikoga.arp.io.OutputWrapper;
import haxe.io.BytesOutput;
import net.kaikoga.arp.io.IOutput;
import haxe.io.Bytes;

class TaggedPersistOutput implements IPersistOutput {

	private var _output:IOutput;

	public var persistLevel(get, never):Int;
	private var _persistLevel:Int = 0;
	private function get_persistLevel():Int return this._persistLevel;


	public function new(output:IOutput, persistLevel:Int = 0) {
		this._output = output;
		this._persistLevel = persistLevel;
	}

	private var _uniqId:Int = 0;
	public function genName():String return '$${_uniqId++}';

	public function writeName(value:String):Void {
		this._output.writeUtfBlob("");
		this._output.writeUtfBlob(value);
	}

	public function writeNameList(name:String, value:Array<String>):Void {
		this._output.writeUtfBlob(name);
		this._output.writeUInt32(value.length);
		for (v in value) this._output.writeUtfBlob(v);
	}

	public function writePersistable(name:String, persistable:IPersistable):Void {
		var bytesOutput:BytesOutput = new BytesOutput();
		persistable.writeSelf(new TaggedPersistOutput(new OutputWrapper(bytesOutput), this._persistLevel));
		this.writeBlob(name, bytesOutput.getBytes());
	}

	public function writeBool(name:String, value:Bool):Void {
		this._output.writeUtfBlob(name);
		this._output.writeBool(value);
	}

	public function writeInt32(name:String, value:Int):Void {
		this._output.writeUtfBlob(name);
		this._output.writeInt32(value);
	}

	public function writeUInt32(name:String, value:Int):Void {
		this._output.writeUtfBlob(name);
		this._output.writeUInt32(value);
	}

	public function writeDouble(name:String, value:Float):Void {
		this._output.writeUtfBlob(name);
		this._output.writeDouble(value);
	}

	public function writeUtf(name:String, value:String):Void {
		this._output.writeUtfBlob(name);
		this._output.writeUtfBlob(value);
	}

	public function writeBlob(name:String, bytes:Bytes):Void {
		this._output.writeUtfBlob(name);
		this._output.writeBlob(bytes);
	}
}

