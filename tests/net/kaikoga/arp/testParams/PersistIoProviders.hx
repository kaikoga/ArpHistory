package net.kaikoga.arp.testParams;

import net.kaikoga.arp.persistable.JsonPersistInput;
import net.kaikoga.arp.persistable.JsonPersistOutput;
import haxe.io.Bytes;
import net.kaikoga.arp.io.OutputWrapper;
import haxe.io.BytesInput;
import net.kaikoga.arp.io.InputWrapper;
import net.kaikoga.arp.persistable.PackedPersistInput;
import net.kaikoga.arp.persistable.PackedPersistOutput;
import haxe.io.BytesOutput;
import net.kaikoga.arp.persistable.AnonPersistInput;
import net.kaikoga.arp.persistable.AnonPersistOutput;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.persistable.IPersistInput;

class PersistIoProviders {

	public static function persistIoProvider():Iterable<Array<Dynamic>> {
		var providers:Array<Array<Dynamic>> = [];
		providers.push([new AnonPersistIoProvider()]);
		providers.push([new JsonPersistIoProvider()]);
		providers.push([new PackedPersistIoProvider()]);
		return providers;
	}

}

typedef IPersistIoProvider = {
	var output(get, never):IPersistOutput;
	var input(get, never):IPersistInput;
}

class AnonPersistIoProvider {
	public var data:Dynamic;
	private var _output:AnonPersistOutput;
	private var _input:AnonPersistInput;

	public function new() {
		this.data = { };
		this._output = new AnonPersistOutput(data);
		this._input = new AnonPersistInput(data);
	}

	public var output(get, never):IPersistOutput;
	public var input(get, never):IPersistInput;
	private function get_output():IPersistOutput return _output;
	private function get_input():IPersistInput return _input;
}

class JsonPersistIoProvider {
	public var data:Dynamic;
	private var _output:JsonPersistOutput;
	private var _input:JsonPersistInput;

	public function new() {
		this._output = new JsonPersistOutput(data);
	}

	public var output(get, never):IPersistOutput;
	public var input(get, never):IPersistInput;
	private function get_output():IPersistOutput return _output;
	private function get_input():IPersistInput {
		if (this._input != null) return this._input;
		return this._input = new JsonPersistInput(this._output.json);
	}
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
