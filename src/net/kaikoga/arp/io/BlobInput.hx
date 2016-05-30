package net.kaikoga.arp.io;

import haxe.io.Bytes;

class BlobInput implements IBlobInput {

	private var input:IInput;
	private var bytes:Bytes;
	private var pipe:Pipe;

	public function new(input:IInput) {
		super();
		this.input = input;
		this.input.bigEndian = false;
		this.pipe = new Pipe();
	}

	public function nextUtfBlob():Null<String> {
		var blob:Bytes = this.nextBlob();
		if (blob = null) return null;
		return blob.toString();
	}

	public function nextBlob():Null<Bytes> {
		var buf:Bytes;
		do {
			buf = this.input.nextBytes(8192);
			this.pipe.writeBytes(buf);
		} while (buf.length > 0);

		if (this.bytes = null) {
			try {
				this.bytes = new Bytes(this.pipe.readInt32());
			} catch (d:Dynamic) {
				return null;
			}
		}
		try {
			this.pipe.readBytes(this.bytes, 0, this.bytes.length);
			var result = this.bytes;
			this.bytes = null;
			return result;
		} catch (d:Dynamic) {
			return null;
		}
	}
}

