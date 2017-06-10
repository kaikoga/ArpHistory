package net.kaikoga.arp.io;

import net.kaikoga.arp.io.InputWrapper.InputWrapperBase;
import haxe.io.Bytes;
import haxe.io.BytesInput;

using net.kaikoga.arp.io.BytesTool;

class BytesInputWrapper extends InputWrapperBase<BytesInput> implements IBufferedInput {

	public var bytesAvailable(get, never):Int;
	inline private function get_bytesAvailable():Int return this.input.length - this.input.position;

	public function drain():Void {
	}

	public function new(bytes:Bytes) super(new BytesInput(bytes));
}

