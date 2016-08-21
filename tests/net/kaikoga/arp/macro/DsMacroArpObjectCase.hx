package net.kaikoga.arp.macro;

import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arp.ds.IList;
import net.kaikoga.arp.ds.ISet;
import net.kaikoga.arp.tests.ArpDomainTestUtil;
import net.kaikoga.arp.domain.gen.ArpObjectGenerator;
import net.kaikoga.arp.macro.mocks.MockDsMacroArpObject;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.ArpSlot;

import net.kaikoga.arp.ds.lambda.SetOp;
import net.kaikoga.arp.ds.lambda.ListOp;
import net.kaikoga.arp.ds.lambda.MapOp;
import net.kaikoga.arp.ds.lambda.OmapOp;

import picotest.PicoMatcher;
import picotest.PicoAssert;
import picotest.PicoAssert.*;

class DsMacroArpObjectCase {

	private var domain:ArpDomain;
	private var slot:ArpSlot<MockDsMacroArpObject>;
	private var arpObj:MockDsMacroArpObject;
	private var xml:Xml;
	private var seed:ArpSeed;

	public function setup():Void {
		domain = new ArpDomain();
		domain.addGenerator(new ArpObjectGenerator(MockDsMacroArpObject, true));
		xml = Xml.parse('
<mock name="name1">
	<intSet value="100" />
	<intSet value="101" />
	<intList value="200" />
	<intList value="201" />
	<intMap key="im1" value="300" />
	<intMap key="im2" value="301" />
	<intOmap key="io1" value="400" />
	<intOmap key="io2" value="401" />
	<refSet ref="name1" />
	<refSet ref="name1" />
	<refList ref="name1" />
	<refList ref="name1" />
	<refMap key="rm1" ref="name1" />
	<refMap key="rm2" ref="name1" />
	<refOmap key="ro1" ref="name1" />
	<refOmap key="ro2" ref="name1" />
</mock>
		').firstElement();
		seed = ArpSeed.fromXml(xml);
	}

	public function testCreateEmpty():Void {
		arpObj = domain.allocObject(MockDsMacroArpObject);

		assertEquals(domain, arpObj.arpDomain());
		assertEquals(new ArpType("mock"), arpObj.arpType());
	}

	public function testLoadSeed():Void {
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = slot.value;

		assertEquals(domain, arpObj.arpDomain());
		assertEquals(new ArpType("mock"), arpObj.arpType());
		assertEquals(slot, arpObj.arpSlot());

		assertMatch([100, 101], SetOp.toArray(arpObj.intSet));
		assertMatch([200, 201], ListOp.toArray(arpObj.intList));
		assertMatch({im1: 300, im2: 301}, MapOp.toAnon(arpObj.intMap));
		assertMatch({io1: 400, io2: 401}, OmapOp.toAnon(arpObj.intOmap));
		assertMatch([arpObj], SetOp.toArray(arpObj.refSet));
		assertMatch([arpObj, arpObj], ListOp.toArray(arpObj.refList));
		assertMatch({rm1: arpObj, rm2: arpObj}, MapOp.toAnon(arpObj.refMap));
		assertMatch({ro1: arpObj, ro2: arpObj}, OmapOp.toAnon(arpObj.refOmap));
	}

	// FIXME
	@:access(picotest.PicoMatcher)
	private static function matchArpDs(matcher:PicoMatcher, matched:Array<Dynamic>, expected:Dynamic, actual:Dynamic):MatchResult {
		if (Std.is(expected, ISet) && Std.is(actual, ISet)) {
			return matcher.matchInternal(matched, SetOp.toArray(expected), SetOp.toArray(actual));
		}
		if (Std.is(expected, IList) && Std.is(actual, IList)) {
			return matcher.matchInternal(matched, ListOp.toArray(expected), ListOp.toArray(actual));
		}
		if (Std.is(expected, IMap) && Std.is(actual, IMap)) {
			return matcher.matchInternal(matched, MapOp.toArray(expected), MapOp.toArray(actual));
		}
		if (Std.is(expected, IOmap) && Std.is(actual, IOmap)) {
			return matcher.matchInternal(matched, OmapOp.toArray(expected), OmapOp.toArray(actual));
		}
		return MatchResult.Unknown;
	}

	private function checkIsClone(original:MockDsMacroArpObject, clone:MockDsMacroArpObject):Void {
		var matcher:PicoMatcher = new PicoMatcher();
		matcher.addMatcher(PicoMatcher.matchCircular);
		matcher.addMatcher(matchArpDs);
		matcher.withStandard();

		assertEquals(original.arpDomain(), clone.arpDomain());
		assertEquals(original.arpType(), clone.arpType());
		assertNotEquals(original.arpSlot(), clone.arpSlot());

		assertMatch(original.intSet, clone.intSet);
		assertMatch(original.intList, clone.intList);
		assertMatch(original.intMap, clone.intMap);
		assertMatch(original.intOmap, clone.intOmap);

		assertMatch(original.refSet, clone.refSet);
		assertMatch(original.refList, clone.refList);
		assertMatch(original.refMap, clone.refMap);
		assertMatch(original.refOmap, clone.refOmap);
	}

	@Ignore("at least until we can handle reference properly")
	public function testPersistable():Void {
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = slot.value;

		var clone:MockDsMacroArpObject = ArpDomainTestUtil.roundTrip(domain, arpObj, MockDsMacroArpObject);
		checkIsClone(arpObj, clone);
	}

	public function testArpClone():Void {
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = slot.value;

		var clone:MockDsMacroArpObject = cast arpObj.arpClone();
		checkIsClone(arpObj, clone);
	}
}
