package net.kaikoga.arp;

import net.kaikoga.arp.structs.ArpStructsUtilCase;
import net.kaikoga.arp.macro.ArpStructsMacroArpObjectCase;
import net.kaikoga.arp.domain.MockArpObjectCase;
import net.kaikoga.arp.macro.StdDsMacroArpObjectCase;
import net.kaikoga.arp.domain.ArpDirectoryCase;
import net.kaikoga.arp.macro.MacroArpObjectCase;
import net.kaikoga.arp.structs.ArpColorCase;
import net.kaikoga.arp.structs.ArpDirectionCase;
import net.kaikoga.arp.structs.ArpPositionCase;
import net.kaikoga.arp.structs.ArpRangeCase;
import net.kaikoga.arp.structs.ArpParamsCase;
import net.kaikoga.arp.domain.query.ArpDirectoryQueryCase;
import net.kaikoga.arp.domain.query.ArpObjectQueryCase;
import net.kaikoga.arp.domain.seed.ArpSeedCase;
import net.kaikoga.arp.domain.ArpDomainCase;

import picotest.PicoTestRunner;

class ArpDomainTestSuite {
	public static function addTo(r:PicoTestRunner) {
		r.load(ArpSeedCase);
		r.load(ArpDirectoryCase);
		r.load(ArpDirectoryQueryCase);
		r.load(ArpObjectQueryCase);

		r.load(MockArpObjectCase);
		r.load(MacroArpObjectCase);
		r.load(ArpStructsMacroArpObjectCase);
		r.load(StdDsMacroArpObjectCase);

		r.load(ArpDomainCase);

		r.load(ArpStructsUtilCase);

		r.load(ArpColorCase);
		r.load(ArpDirectionCase);
		r.load(ArpParamsCase);
		r.load(ArpPositionCase);
		r.load(ArpRangeCase);
	}
}
