package net.kaikoga.arp;

import net.kaikoga.arp.structs.ArpArea2dCase;
import net.kaikoga.arp.macro.DsMacroArpObjectCase;
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
import net.kaikoga.arp.seed.ArpSeedCase;
import net.kaikoga.arp.domain.ArpDomainCase;

import net.kaikoga.arp.testParams.PersistIoProviders.*;

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
		r.load(DsMacroArpObjectCase);
		r.load(HookMacroArpObjectCase);
		r.load(HeatUpMacroArpObjectCase);
		r.load(LatePrepareMacroArpObjectCase);
		r.load(EarlyPrepareMacroArpObjectCase);

		r.load(ArpDomainCase);

		r.load(ArpStructsUtilCase);

		//r.load(ArpArea2dCase, persistIoProvider());
		r.load(ArpColorCase, persistIoProvider());
		r.load(ArpDirectionCase, persistIoProvider());
		r.load(ArpParamsCase, persistIoProvider());
		r.load(ArpPositionCase, persistIoProvider());
		r.load(ArpRangeCase, persistIoProvider());

		ArpDomainDsCompatTestSuite.addTo(r);

		#if (flash || openfl)
		r.load(ArpColorFlashCase);
		#end

	}
}
