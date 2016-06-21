package net.kaikoga.arp.persistable;

import net.kaikoga.arp.testParams.PersistIoProviders.AnonPersistIoProvider;
import net.kaikoga.arp.persistable.MockPersistable;

import picotest.PicoAssert.*;

class AnonPersistIoCase {

	private var provider:AnonPersistIoProvider;

	public function new() {
	}

	public function setup():Void {
		this.provider = new AnonPersistIoProvider();
	}

	// TODO unit test
	public function testPersistFormat():Void {
		var obj:MockPersistable = new MockPersistable(true);
		this.provider.output.writePersistable("obj", obj);
		assertNotNull(this.provider.data);
	}
}
