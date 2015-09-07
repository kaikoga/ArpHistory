package net.kaikoga.arp.persistable;

import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.PackedPersistInput;
import net.kaikoga.arp.persistable.PackedPersistOutput;
import net.kaikoga.arp.persistable.TestPersistable;


import flash.utils.ByteArray;

import org.flexunit.asserts.AssertEquals;

class PackedPersistIoTest {
	private var input(get, never):IPersistInput;


	private var bytes:ByteArray;
	private var output:PackedPersistOutput;
	private var _input:PackedPersistInput;

	private function get_Input():IPersistInput {
		if (!this._input) {
			this.bytes.position = 0;
			this._input = new PackedPersistInput(this.bytes);
		}
		return this._input;
	}

	public function new() {
		super();
	}

	@:meta(Before())

	public function setup():Void {
		this.bytes = new ByteArray();
		this.output = new PackedPersistOutput(this.bytes);
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


