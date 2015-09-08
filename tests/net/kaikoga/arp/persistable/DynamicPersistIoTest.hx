package net.kaikoga.arp.persistable;

import net.kaikoga.arp.persistable.ObjectPersistInput;
import net.kaikoga.arp.persistable.ObjectPersistOutput;
import net.kaikoga.arp.persistable.MockPersistable;

import picotest.PicoAssert.*;

class DynamicPersistIoTest {

	private var data:Dynamic;
	private var output:ObjectPersistOutput;
	private var input:ObjectPersistInput;

	public function new() {
	}

	public function setup():Void {
		this.data = { };
		this.output = new ObjectPersistOutput(this.data);
		this.input = new ObjectPersistInput(this.data);
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
