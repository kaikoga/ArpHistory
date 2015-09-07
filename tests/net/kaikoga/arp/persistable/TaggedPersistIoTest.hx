package net.kaikoga.arp.persistable;

import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.TaggedPersistInput;
import net.kaikoga.arp.persistable.TaggedPersistOutput;
import net.kaikoga.arp.persistable.TestPersistable;


import flash.utils.ByteArray;

import org.flexunit.asserts.AssertEquals;

class TaggedPersistIoTest {
	private var input(get, never):IPersistInput;


	private var bytes:ByteArray;
	private var output:TaggedPersistOutput;
	private var _input:TaggedPersistInput;

	private function get_Input():IPersistInput {
		if (!this._input) {
			this.bytes.position = 0;
			this._input = new TaggedPersistInput(this.bytes);
		}
		return this._input;
	}

	public function new() {
		super();
	}

	@:meta(Before())

	public function setup():Void {
		this.bytes = new ByteArray();
		this.output = new TaggedPersistOutput(this.bytes);
		this._input = null;
	}

	@:meta(Test())

	public function persistableTest():Void {
		var obj:TestPersistable = new TestPersistable(true);
		this.output.writePersistable("obj", obj);
		var obj2:TestPersistable = new TestPersistable(true);
		this.input.readPersistable("obj", obj2);
		Assert.areEqual(Std.string(obj), Std.string(obj2));
	}
}


