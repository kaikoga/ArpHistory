package net.kaikoga.arp;

import net.kaikoga.arp.ds.ListCase;
import net.kaikoga.arp.ds.MapCase;
import net.kaikoga.arp.ds.OmapCase;
import net.kaikoga.arp.ds.SetCase;
import net.kaikoga.arp.testParams.ArpObjectDsImplProviders.*;
import picotest.PicoTestRunner;

class ArpDomainDsCompatTestSuite {
	public static function addTo(r:PicoTestRunner) {
		r.load(SetCase, arpObjectSetProvider());
		r.load(ListCase, arpObjectListProvider());
		r.load(MapCase, arpObjectMapProvider());
		r.load(OmapCase, arpObjectOmapProvider());
	}
}
