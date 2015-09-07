package net.kaikoga.arp.persistable;

import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.ObjectPersistInput;
import net.kaikoga.arp.persistable.ObjectPersistOutput;
import net.kaikoga.arp.persistable.TestPersistable;


import org.flexunit.asserts.AssertEquals;

class DynamicPersistIoTest {
	private var input(get, never):IPersistInput;


	private var data:Dynamic;
	private var output:ObjectPersistOutput;
	private var _input:ObjectPersistInput;

	private function get_Input():IPersistInput {
		if (!this._input) {
			this._input = new ObjectPersistInput(this.data);
		}
		return this._input;
	}

	public function new() {
		super();
	}

	@:meta(Before())

	public function setup():Void {
		this.data = { };
		this.output = new ObjectPersistOutput(this.data);
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


