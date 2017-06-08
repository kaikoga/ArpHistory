package net.kaikoga.arp.io;

import haxe.io.Bytes;

class BufferedInput implements IBufferedInput {

	public var bigEndian(get, set):Bool;
	private function get_bigEndian():Bool return this.input.bigEndian;
	private function set_bigEndian(value:Bool):Bool {
		this.input.bigEndian = value;
		this.fifo.bigEndian = value;
		return value;
	}

	public var bytesAvailable(get, never):Int;
	private function get_bytesAvailable():Int {
		drain();
		return this.fifo.bytesAvailable;
	}

	private var _input:IInput;
	public var input(get, set):IInput;
	inline function get_input():IInput return _input;
	inline function set_input(value:IInput):IInput return this._input = value;

	private var fifo:Fifo;

	public function new(input:IInput = null) {
		this.input = input;
		this.fifo = new Fifo();
	}

	private function drain():Void {
		var buf:Bytes;
		while (this.input != null) {
			buf = this.input.nextBytes(8192);
			if (buf.length == 0) {
				this.input = null;
			} else {
				this.fifo.writeBytes(buf, 0, buf.length);
			}
		}
	}

	public function readBool():Bool {
		drain();
		return this.fifo.readBool();
	}

	public function readInt8():Int {
		drain();
		return this.fifo.readInt8();
	}
	public function readInt16():Int {
		drain();
		return this.fifo.readInt16();
	}
	public function readInt32():Int {
		drain();
		return this.fifo.readInt32();
	}

	public function readUInt8():UInt {
		drain();
		return this.fifo.readUInt8();
	}
	public function readUInt16():UInt {
		drain();
		return this.fifo.readUInt16();
	}
	public function readUInt32():UInt {
		drain();
		return this.fifo.readUInt32();
	}

	public function readFloat():Float {
		drain();
		return this.fifo.readFloat();
	}
	public function readDouble():Float {
		drain();
		return this.fifo.readDouble();
	}

	public function readBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void {
		drain();
		return this.fifo.readBytes(bytes, offset, length);
	}
	public function readUtfBytes(length:UInt):String {
		drain();
		return this.fifo.readUtfBytes(length);
	}

	public function readBlob():Bytes {
		drain();
		return this.fifo.readBlob();
	}
	public function readUtfBlob():String {
		drain();
		return this.fifo.readUtfBlob();
	}

	public function nextBytes(limit:Int = 0):Bytes {
		drain();
		return this.fifo.nextBytes(limit);
	}
}

