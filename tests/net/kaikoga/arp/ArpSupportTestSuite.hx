package net.kaikoga.arp;

import net.kaikoga.arp.persistable.TaggedPersistIoCase;
import net.kaikoga.arp.persistable.PackedPersistIoCase;
import net.kaikoga.arp.persistable.DynamicPersistIoCase;

import picotest.PicoTestRunner;

class ArpSupportTestSuite {
	public static function addTo(r:PicoTestRunner) {
		r.load(DynamicPersistIoCase);
		r.load(PackedPersistIoCase);
		r.load(TaggedPersistIoCase);

	}
}
