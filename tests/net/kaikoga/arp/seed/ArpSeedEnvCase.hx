package net.kaikoga.arp.seed;

import picotest.PicoAssert.*;

class ArpSeedEnvCase {

	public function testArpSeedEnv():Void {
		var env1:ArpSeedEnv = ArpSeedEnv.empty();
		assertMatch(env1.get("key"), null);
		env1.add("key", "value");
		var env2:ArpSeedEnv = env1;
		assertMatch(env1.get("key"), "value");
		assertMatch(env2.get("key"), "value");
		env1.add("key1", "value1");
		env2.add("key2", "value2");
		assertMatch(env1.get("key1"), "value1");
		assertMatch(env1.get("key2"), null);
		assertMatch(env2.get("key1"), null);
		assertMatch(env2.get("key2"), "value2");
	}
}
