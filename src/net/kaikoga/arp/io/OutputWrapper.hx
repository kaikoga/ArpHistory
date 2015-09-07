package net.kaikoga.arp.io;

import haxe.io.Bytes;
import haxe.io.Output;
import net.kaikoga.net.IInput;
import net.kaikoga.net.IOutput;

class OutputWrapper implements IOutput
{
	public var bigEndian(get, set):Bool;
	private function get_bigEndian():Bool return this.output.bigEndian;
	private function set_bigEndian(value:Bool):Bool return this.output.bigEndian = value;
	
	private var output:Output;

	public function new(output:Output) this.output = output;

	public function writeBool(value:Bool):Void this.output.writeByte(value ? -1 : 0);

	public function writeInt8(value:Int):Void this.output.writeInt8(value);
	public function writeInt16(value:Int):Void this.output.writeInt16(value);
	public function writeInt32(value:Int):Void this.output.writeInt32(value);

	public function writeUInt8(value:UInt):Void this.output.writeByte(value);
	public function writeUInt16(value:UInt):Void this.output.writeUInt16(value);
	public function writeUInt32(value:UInt):Void this.output.writeUInt32(value);

	public function writeSingle(value:Float):Void this.output.writeFloat(value);
	public function writeDouble(value:Float):Void this.output.writeDouble(value);

	public function writeBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void {
		this.output.writeFullBytes(bytes, offset, length);
	}
	public function writeUtfBytes(value:String):Void {
		var bytes:Bytes = Bytes.ofString(value);
		this.writeBytes(bytes, 0, bytes.length);
	}

	public function writeBlob(bytes:Bytes, offset:Int = 0, length:Int = 0):Void {
		this.output.writeInt32(length);
		this.output.writeFullBytes(bytes, offset, length);
	}
	public function writeUtfBlob(value:String):Void {
		var bytes:Bytes = Bytes.ofString(value);
		this.output.writeInt32(bytes.length);
		this.writeBlob(bytes, 0, bytes.length);
	}
}

