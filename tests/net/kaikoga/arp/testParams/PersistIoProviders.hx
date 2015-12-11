package net.kaikoga.arp.testParams;


import haxe.io.Bytes;
import net.kaikoga.arp.persistable.TaggedPersistInput;
import net.kaikoga.arp.persistable.TaggedPersistOutput;
import net.kaikoga.arp.io.OutputWrapper;
import haxe.io.BytesInput;
import net.kaikoga.arp.io.InputWrapper;
import net.kaikoga.arp.persistable.PackedPersistInput;
import net.kaikoga.arp.persistable.PackedPersistOutput;
import haxe.io.BytesOutput;
import net.kaikoga.arp.persistable.DynamicPersistInput;
import net.kaikoga.arp.persistable.DynamicPersistOutput;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.persistable.IPersistInput;

class PersistIoProviders {

	public static function persistIoProvider():Iterable<Array<Dynamic>> {
		return [
			[new DynamicPersistIoProvider()],
			[new PackedPersistIoProvider()],
			[new TaggedPersistIoProvider()]
		];
	}

}

typedef IPersistIoProvider = {
	var output(get, never):IPersistOutput;
	var input(get, never):IPersistInput;
}

class DynamicPersistIoProvider {
	public var data:Dynamic;
	private var _output:DynamicPersistOutput;
	private var _input:DynamicPersistInput;

	public function new() {
		this.data = { };
		this._output = new DynamicPersistOutput(data);
		this._input = new DynamicPersistInput(data);
	}

	public var output(get, never):IPersistOutput;
	public var input(get, never):IPersistInput;
	private function get_output():IPersistOutput return _output;
	private function get_input():IPersistInput return _input;
}

class PackedPersistIoProvider {
	public var bytesOutput:BytesOutput;
	private var _output:PackedPersistOutput;
	private var _input:PackedPersistInput;

	public function new() {
		this.bytesOutput = new BytesOutput();
		this._output = new PackedPersistOutput(new OutputWrapper(this.bytesOutput));
	}
	public var output(get, never):IPersistOutput;
	public var input(get, never):IPersistInput;
	private function get_output():IPersistOutput return _output;
	private function get_input():IPersistInput {
		if (this._input != null) return this._input;
		return this._input = new PackedPersistInput(new InputWrapper(new BytesInput(this.bytes)));
	}

	public var bytes(get, never):Bytes;
	private function get_bytes():Bytes return this.bytesOutput.getBytes();
}

class TaggedPersistIoProvider {
	public var bytesOutput:BytesOutput;
	private var _output:TaggedPersistOutput;
	private var _input:TaggedPersistInput;

	public function new() {
		this.bytesOutput = new BytesOutput();
		this._output = new TaggedPersistOutput(new OutputWrapper(this.bytesOutput));
	}

	public var output(get, never):IPersistOutput;
	public var input(get, never):IPersistInput;
	private function get_output():IPersistOutput return _output;
	private function get_input():IPersistInput {
		if (this._input != null) return this._input;
		return this._input = new TaggedPersistInput(new InputWrapper(new BytesInput(this.bytes)));
	}

	public var bytes(get, never):Bytes;
	private function get_bytes():Bytes return this.bytesOutput.getBytes();
}
