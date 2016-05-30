package net.kaikoga.arp.io;

import haxe.io.Bytes;

class BlobOutput implements IBlobOutput {

	private var output:IOutput;

	public function new(output:IOutput) {
		this.output = output;
		this.output.bigEndian = false;
	}

	public function writeBlob(bytes:Bytes):Void {
		this.output.writeBlob(bytes);
	}

	public function writeUtfBlob(value:String):Void {
		this.output.writeUtfBlob(value);
	}
}

