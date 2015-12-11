package net.kaikoga.arp.persistable;

import net.kaikoga.arp.testParams.PersistIoProviders.PackedPersistIoProvider;
import net.kaikoga.arp.persistable.MockPersistable;

import picotest.PicoAssert.*;

class PackedPersistIoCase {

	private var provider:PackedPersistIoProvider;

	public function new() {
	}

	public function setup():Void {
		this.provider = new PackedPersistIoProvider();
	}

	// TODO unit test
	public function testPersistFormat():Void {
		var obj:MockPersistable = new MockPersistable(true);
		this.provider.output.writePersistable("obj", obj);
		assertNotNull(this.provider.bytes);
	}
}
