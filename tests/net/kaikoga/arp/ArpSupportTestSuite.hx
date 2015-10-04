package net.kaikoga.arp;

import net.kaikoga.arp.ds.impl.base.BaseCollectionCase;
import net.kaikoga.arp.ds.impl.StdMapListCase;
import net.kaikoga.arp.ds.impl.StdMapCase;
import net.kaikoga.arp.ds.impl.ArrayListCase;
import net.kaikoga.arp.ds.impl.VoidCollectionCase;
import net.kaikoga.arp.ds.impl.ArraySetCase;
import net.kaikoga.arp.persistable.TaggedPersistIoCase;
import net.kaikoga.arp.persistable.PackedPersistIoCase;
import net.kaikoga.arp.persistable.DynamicPersistIoCase;

import picotest.PicoTestRunner;

class ArpSupportTestSuite {
	public static function addTo(r:PicoTestRunner) {
		r.load(VoidCollectionCase);
		r.load(BaseCollectionCase);
		r.load(ArraySetCase);
		r.load(ArrayListCase);
		r.load(StdMapCase);
		r.load(StdMapListCase);
		
		r.load(DynamicPersistIoCase);
		r.load(PackedPersistIoCase);
		r.load(TaggedPersistIoCase);
	}
}