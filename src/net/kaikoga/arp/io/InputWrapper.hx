package net.kaikoga.arp.io;

import haxe.io.Bytes;
import haxe.io.Input;
import net.kaikoga.net.IInput;
import net.kaikoga.net.IOutput;

class InputWrapper implements IInput {
	
	public var bigEndian(get, set):Bool;
	private function get_bigEndian():Bool return this.input.bigEndian;
	private function set_bigEndian(value:Bool):Bool return this.input.bigEndian = value;
	
	private var input:Input;

	public function new(input:Input) this.input = input;
	
	public function readBool():Bool return this.input.readByte() != 0;

	public function readInt8():Int return this.input.readInt8();
	public function readInt16():Int return this.input.readInt16();
	public function readInt32():Int return this.input.readInt32();

	public function readUInt8():UInt return this.input.readByte();
	public function readUInt16():UInt return this.input.readUInt16();
	public function readUInt32():UInt return this.input.readUInt32();

	public function readSingle():Float return this.input.readFloat();
	public function readDouble():Float return this.input.readDouble();

	public function readBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void {
		return this.input.readFullBytes(bytes, offset, length);
	}
	public function readUtfBytes(length:UInt):String {
		return this.input.readFullBytes(bytes, offset, length).toString();
	}

	public function readBlob(bytes:Bytes = null, offset:Int = 0):Void {
		var length:Int = this.input.readInt32();
		return this.input.readFullBytes(bytes, offset, length);
	}
	public function readUtfBlob():String {
		var length:Int = this.input.readInt32();
		return this.input.readString(length);
	}
}

