package net.kaikoga.arp;

import net.kaikoga.arp.domain.ArpDirectoryCase;
import net.kaikoga.arp.domain.ArpDomainCase;
import net.kaikoga.arp.domain.MockArpObjectCase;
import net.kaikoga.arp.domain.MockDerivedArpObjectCase;
import net.kaikoga.arp.domain.query.ArpDirectoryQueryCase;
import net.kaikoga.arp.domain.query.ArpObjectQueryCase;
import net.kaikoga.arp.macro.DsMacroArpObjectCase;
import net.kaikoga.arp.macro.EarlyPrepareMacroArpObjectCase;
import net.kaikoga.arp.macro.HeatUpMacroArpObjectCase;
import net.kaikoga.arp.macro.HookMacroArpObjectCase;
import net.kaikoga.arp.macro.LatePrepareMacroArpObjectCase;
import net.kaikoga.arp.macro.MacroArpObjectCase;
import net.kaikoga.arp.macro.MacroColumnArpObjectCase;
import net.kaikoga.arp.macro.MacroConcreteImplArpObjectCase;
import net.kaikoga.arp.macro.MacroDefaultArpObjectCase;
import net.kaikoga.arp.macro.MacroDerivedArpObjectCase;
import net.kaikoga.arp.macro.MacroHierarchicalArpObjectCase;
import net.kaikoga.arp.macro.MacroImplArpObjectCase;
import net.kaikoga.arp.macro.StdDsMacroArpObjectCase;
import net.kaikoga.arp.tests.ArpDomainTestUtilCase;
import picotest.PicoTestRunner;

class ArpDomainTestSuite {
	public static function addTo(r:PicoTestRunner) {
		r.load(ArpDomainTestUtilCase);

		r.load(ArpDirectoryCase);
		r.load(ArpDirectoryQueryCase);
		r.load(ArpObjectQueryCase);

		r.load(MockArpObjectCase);
		r.load(MockDerivedArpObjectCase);

		r.load(MacroArpObjectCase);
		r.load(MacroDefaultArpObjectCase);
		r.load(MacroHierarchicalArpObjectCase);
		r.load(MacroColumnArpObjectCase);
		r.load(MacroDerivedArpObjectCase);
		r.load(StdDsMacroArpObjectCase);
		r.load(DsMacroArpObjectCase);
		r.load(HookMacroArpObjectCase);
		r.load(HeatUpMacroArpObjectCase);
		r.load(LatePrepareMacroArpObjectCase);
		r.load(EarlyPrepareMacroArpObjectCase);
		r.load(MacroImplArpObjectCase);
		r.load(MacroConcreteImplArpObjectCase);

		r.load(ArpDomainCase);

		ArpDomainDsCompatTestSuite.addTo(r);
	}
}
