package net.kaikoga.arp.persistable;

import net.kaikoga.arp.testParams.PersistIoProviders.JsonPersistIoProvider;
import net.kaikoga.arp.persistable.MockPersistable;

import picotest.PicoAssert.*;

class JsonPersistIoCase {

	private var provider:JsonPersistIoProvider;

	public function new() {
	}

	public function setup():Void {
		this.provider = new JsonPersistIoProvider();
	}

	// TODO unit test
	public function testPersistFormat():Void {
		var obj:MockPersistable = new MockPersistable(true);
		this.provider.output.writePersistable("obj", obj);
		assertNotNull(this.provider.data);
	}
}
