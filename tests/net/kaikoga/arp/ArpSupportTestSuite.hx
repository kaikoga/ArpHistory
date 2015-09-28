package net.kaikoga.arp;

import net.kaikoga.arp.ds.impl.VoidCollectionCase;
import net.kaikoga.arp.ds.impl.ArraySetCase;
import net.kaikoga.arp.persistable.TaggedPersistIoCase;
import net.kaikoga.arp.persistable.PackedPersistIoCase;
import net.kaikoga.arp.persistable.DynamicPersistIoCase;

import picotest.PicoTestRunner;

class ArpSupportTestSuite {
	public static function addTo(r:PicoTestRunner) {
		r.load(VoidCollectionCase);
		r.load(ArraySetCase);
		
		r.load(DynamicPersistIoCase);
		r.load(PackedPersistIoCase);
		r.load(TaggedPersistIoCase);
	}
}
