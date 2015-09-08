package net.kaikoga.arp.persistable;

import haxe.io.BytesOutput;
import net.kaikoga.arp.io.OutputWrapper;
import net.kaikoga.arp.io.InputWrapper;
import haxe.io.BytesInput;
import net.kaikoga.arp.persistable.TaggedPersistInput;
import net.kaikoga.arp.persistable.TaggedPersistOutput;
import net.kaikoga.arp.persistable.MockPersistable;

import picotest.PicoAssert.*;

class TaggedPersistIoTest {

	private var bytesOutput:BytesOutput;
	private var output:TaggedPersistOutput;
	private var input(get, never):IPersistInput;
	private var _input:TaggedPersistInput;
	private function get_input():IPersistInput {
		if (this._input != null) return this._input;
		return this._input = new TaggedPersistInput(new InputWrapper(new BytesInput(this.bytesOutput.getBytes())));
	}

	public function new() {
	}

	public function setup():Void {
		this.bytesOutput = new BytesOutput();
		this.output = new TaggedPersistOutput(new OutputWrapper(this.bytesOutput));
	}

	// TODO unit test
	public function testPersistable():Void {
		var obj:MockPersistable = new MockPersistable(true);
		this.output.writePersistable("obj", obj);
		var obj2:MockPersistable = new MockPersistable(true);
		this.input.readPersistable("obj", obj2);
		assertEquals(Std.string(obj), Std.string(obj2));
	}
}
