package net.kaikoga.arp.persistable;

import net.kaikoga.arp.testParams.PersistIoProviders.TaggedPersistIoProvider;
import net.kaikoga.arp.persistable.MockPersistable;

import picotest.PicoAssert.*;

class TaggedPersistIoCase {
	
	private var provider:TaggedPersistIoProvider;

	public function new() {
	}

	public function setup():Void {
		this.provider = new TaggedPersistIoProvider();
	}

	// TODO unit test
	public function testPersistFormat():Void {
		var obj:MockPersistable = new MockPersistable(true);
		this.provider.output.writePersistable("obj", obj);
		assertNotNull(this.provider.bytes);
	}
}
