package arp.seed;

import arp.seed.impl.ArpSimpleSeed;
import arp.utils.ArpIdGenerator;

import picotest.PicoAssert.*;
import org.hamcrest.Matcher;
import org.hamcrest.Matchers;

class ArpSeedEnvCase {

	private var autoKey(get, never):Matcher<Dynamic>;
	public function get_autoKey():Matcher<Dynamic> return Matchers.startsWith(ArpIdGenerator.AUTO_HEADER);

	private function toHash(seed:ArpSeed) return {
		typeName: Std.string(seed.typeName),
		className: seed.className,
		name: seed.name,
		key: seed.key,
		value: seed.value,
		kind: switch (seed.valueKind) {
			case ArpSeedValueKind.None: "n";
			case ArpSeedValueKind.Ambigious: "a";
			case ArpSeedValueKind.Literal: "l";
			case ArpSeedValueKind.Reference: "r";
		}
	};

	public function testAdd():Void {
		var env1:ArpSeedEnv = ArpSeedEnv.empty();
		assertMatch(null, env1.get("key"));
		env1.add("key", "value");
		var env2:ArpSeedEnv = env1;
		assertMatch("value", env1.get("key"));
		assertMatch("value", env2.get("key"));
		env1.add("key1", "value1");
		env2.add("key2", "value2");
		assertMatch("value1", env1.get("key1"));
		assertMatch(null, env1.get("key2"));
		assertMatch(null, env2.get("key1"));
		assertMatch("value2", env2.get("key2"));
	}

	public function testDefaultClass():Void {
		var env1:ArpSeedEnv = ArpSeedEnv.empty();
		assertMatch(null, env1.getDefaultClass("key"));
		env1.add("default.key", "value");
		assertMatch("value", env1.getDefaultClass("key"));
	}

	public function testAddSeeds():Void {
		var env1:ArpSeedEnv = ArpSeedEnv.empty();
		var seed:ArpSimpleSeed = new ArpSimpleSeed("tt", "kk", "vv", env1, ArpSeedValueKind.Literal);
		env1.addSeeds("default.key", "value", [seed]);
		assertMatch([seed], env1.getDefaultSeeds("key"));
	}

	public function testEmptyXmlEnv():Void {
		var xml:Xml = Xml.parse('<root />').firstElement();
		var env:ArpSeedEnv = ArpSeed.fromXml(xml).env;
		assertTrue(env != null);
		assertTrue(env == ArpSeedEnv.empty());
	}

	public function testXmlEnv():Void {
		var xml:Xml = Xml.parse('<root><env name="default.key" value="value" /></root>').firstElement();
		var env:ArpSeedEnv = ArpSeed.fromXml(xml).env;
		assertTrue(env != null);
		assertTrue(env != ArpSeedEnv.empty());
		assertMatch("value", env.get("default.key"));
		assertMatch("value", env.getDefaultClass("key"));
	}

	public function testXmlEnvSeedsRootScope():Void {
		var xml:Xml = Xml.parse('<key dummy="root"><env name="default.key" value="value" a="b"><c /></env></key>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		var env:ArpSeedEnv = seed.env;
		assertTrue(env != null);
		assertTrue(env != ArpSeedEnv.empty());
		assertMatch("value", env.get("default.key"));
		assertMatch(2, env.getDefaultSeeds("key").length);
		assertMatch("a", env.getDefaultSeeds("key")[0].typeName);
		assertMatch("c", env.getDefaultSeeds("key")[1].typeName);
	}

	public function testXmlEnvSeedsIteratorRootScope():Void {
		var xml:Xml = Xml.parse('<key dummy="root"><env name="default.key" value="value" a="b"><c /></env></key>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertMatch({typeName: "key", className: null, name: null, key: autoKey, value: null, kind: "n"}, toHash(seed));
		var iterator = seed.iterator();

		assertTrue(iterator.hasNext());
		assertMatch({typeName: "a", className: null, name: null, key: autoKey, value: "b", kind: "a"}, toHash(iterator.next()));
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "c", className: null, name: null, key: autoKey, value: null, kind: "l"}, toHash(iterator.next()));
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "dummy", className: null, name: null, key: autoKey, value: "root", kind: "a"}, toHash(iterator.next()));

		assertFalse(iterator.hasNext());
	}

	public function testXmlEnvSeedsChildScope():Void {
		var xml:Xml = Xml.parse('<root><key dummy="before" /><env name="default.key" value="value" a="b"><c /></env><key dummy="after" /></root>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		var iterator = seed.iterator();

		assertTrue(iterator.hasNext());
		var before:ArpSeed = iterator.next();
		assertMatch("key", before.typeName);
		assertMatch(null, before.env.get("default.key"));
		assertMatch(0, before.env.getDefaultSeeds("key").length);

		assertTrue(iterator.hasNext());
		var after:ArpSeed = iterator.next();
		assertMatch("key", after.typeName);
		assertMatch("value", after.env.get("default.key"));
		assertMatch(2, after.env.getDefaultSeeds("key").length);

		assertFalse(iterator.hasNext());
	}

	public function testXmlEnvSeedsIteratorChildScope():Void {
		var xml:Xml = Xml.parse('<root><key dummy="before" /><env name="default.key" value="value" a="b"><c /></env><key dummy="after" /></root>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertMatch({typeName: "root", className: null, name: null, key: autoKey, value: null, kind: "n"}, toHash(seed));
		var iterator = seed.iterator();

		assertTrue(iterator.hasNext());
		var before:ArpSeed = iterator.next();
		assertMatch({typeName: "key", className: null, name: null, key: autoKey, value: null, kind: "n"}, toHash(before));
		var beforeIterator = before.iterator();
		assertTrue(beforeIterator.hasNext());
		assertMatch({typeName: "dummy", className: null, name: null, key: autoKey, value: "before", kind: "a"}, toHash(beforeIterator.next()));
		assertFalse(beforeIterator.hasNext());

		assertTrue(iterator.hasNext());
		var after:ArpSeed = iterator.next();
		assertMatch({typeName: "key", className: null, name: null, key: autoKey, value: null, kind: "n"}, toHash(after));
		var afterIterator = after.iterator();
		assertTrue(afterIterator.hasNext());
		assertMatch({typeName: "a", className: null, name: null, key: autoKey, value: "b", kind: "a"}, toHash(afterIterator.next()));
		assertTrue(afterIterator.hasNext());
		assertMatch({typeName: "c", className: null, name: null, key: autoKey, value: null, kind: "l"}, toHash(afterIterator.next()));
		assertTrue(afterIterator.hasNext());
		assertMatch({typeName: "dummy", className: null, name: null, key: autoKey, value: "after", kind: "a"}, toHash(afterIterator.next()));
		assertFalse(afterIterator.hasNext());

		assertFalse(iterator.hasNext());
	}
}
