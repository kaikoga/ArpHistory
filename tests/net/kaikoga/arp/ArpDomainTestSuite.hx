package net.kaikoga.arp;

import net.kaikoga.arp.macro.EarlyPrepareMacroArpObjectCase;
import net.kaikoga.arp.macro.LatePrepareMacroArpObjectCase;
import net.kaikoga.arp.structs.ArpColorFlashCase;
import net.kaikoga.arp.macro.MacroColumnArpObjectCase;
import net.kaikoga.arp.domain.MockColumnArpObjectCase;
import net.kaikoga.arp.tests.ArpDomainTestUtilCase;
import net.kaikoga.arp.macro.MacroDerivedArpObjectCase;
import net.kaikoga.arp.domain.MockDerivedArpObjectCase;
import net.kaikoga.arp.macro.HeatUpMacroArpObjectCase;
import net.kaikoga.arp.macro.HookMacroArpObjectCase;
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
		r.load(ArpDomainTestUtilCase);

		r.load(ArpSeedCase);
		r.load(ArpDirectoryCase);
		r.load(ArpDirectoryQueryCase);
		r.load(ArpObjectQueryCase);

		r.load(MockArpObjectCase);
		r.load(MockColumnArpObjectCase);
		r.load(MockDerivedArpObjectCase);

		r.load(MacroArpObjectCase);
		r.load(MacroColumnArpObjectCase);
		r.load(MacroDerivedArpObjectCase);
		r.load(ArpStructsMacroArpObjectCase);
		r.load(StdDsMacroArpObjectCase);
		r.load(HookMacroArpObjectCase);
		r.load(HeatUpMacroArpObjectCase);
		r.load(LatePrepareMacroArpObjectCase);
		r.load(EarlyPrepareMacroArpObjectCase);

		r.load(ArpDomainCase);

		r.load(ArpStructsUtilCase);

		r.load(ArpColorCase);
		r.load(ArpDirectionCase);
		r.load(ArpParamsCase);
		r.load(ArpPositionCase);
		r.load(ArpRangeCase);

		ArpDomainDsCompatTestSuite.addTo(r);

		#if (flash || openfl)
		r.load(ArpColorFlashCase);
		#end

	}
}
