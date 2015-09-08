package net.kaikoga.arp.persistable;

import net.kaikoga.arp.persistable.DynamicPersistInput;
import net.kaikoga.arp.persistable.DynamicPersistOutput;
import net.kaikoga.arp.persistable.MockPersistable;

import picotest.PicoAssert.*;

class DynamicPersistIoTest {

	private var data:Dynamic;
	private var output:DynamicPersistOutput;
	private var input:DynamicPersistInput;

	public function new() {
	}

	public function setup():Void {
		this.data = { };
		this.output = new DynamicPersistOutput(this.data);
		this.input = new DynamicPersistInput(this.data);
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
