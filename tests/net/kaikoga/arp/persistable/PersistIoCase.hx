package net.kaikoga.arp.persistable;

import net.kaikoga.arp.testParams.PersistIoProviders.IPersistIoProvider;
import net.kaikoga.arp.persistable.MockPersistable;

import picotest.PicoAssert.*;

class PersistIoCase {

	private var provider:IPersistIoProvider;
	
	public function new() {
	}

	@Parameter
	public function setup(provider:IPersistIoProvider):Void {
		this.provider = provider;
	}

	public function testRoundTrip():Void {
		var obj:MockPersistable = new MockPersistable(true);
		this.provider.output.writePersistable("obj", obj);
		var obj2:MockPersistable = new MockPersistable(true);
		this.provider.input.readPersistable("obj", obj2);
		assertEquals(Std.string(obj), Std.string(obj2));
	}
}
