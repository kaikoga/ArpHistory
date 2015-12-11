package net.kaikoga.arp.persistable;

import net.kaikoga.arp.testParams.PersistIoProviders.DynamicPersistIoProvider;
import net.kaikoga.arp.persistable.MockPersistable;

import picotest.PicoAssert.*;

class DynamicPersistIoCase {

	private var provider:DynamicPersistIoProvider;

	public function new() {
	}

	public function setup():Void {
		this.provider = new DynamicPersistIoProvider();
	}

	// TODO unit test
	public function testPersistFormat():Void {
		var obj:MockPersistable = new MockPersistable(true);
		this.provider.output.writePersistable("obj", obj);
		assertNotNull(this.provider.data);
	}
}
