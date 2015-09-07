package net.kaikoga.arp.structs;

import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.structs.ArpParams;

import org.hamcrest.Matchers;
import picotest.PicoAssert.*;

class ArpParamsCase {

	public function new() {
	}

	public function testAddParam():Void {
		var params:ArpParams = new ArpParams();
		params["a"] = "b";
		params["c"] = 10;
		params["d"] = ArpDirection.LEFT;
		params.addParam("e", "f");
		params["g"] = new ArpParamRewire("h");
		assertEquals("b", params["a"]);
		assertEquals(10, params["c"]);
		assertEquals(ArpDirection.LEFT.value, params["d"].value);
		assertEquals("f", params["e"]);
		assertEquals("h", params["g"].rewireFrom);
	}

	public function testToString():Void {
		var params:ArpParams = new ArpParams();
		assertEquals("", Std.string(params));
		params["a"] = "b";
		assertMatch(["a:b"], Std.string(params).split(","));
		params["c"] = 10;
		assertMatch(Matchers.containsInAnyOrder("a:b", "c:10"), Std.string(params).split(","));
		params["d"] = ArpDirection.LEFT;
		assertMatch(Matchers.containsInAnyOrder("a:b", "c:10", "d:2147483648:dir"), Std.string(params).split(","));
		params["g"] = new ArpParamRewire("h");
		assertMatch(Matchers.containsInAnyOrder("a:b", "c:10", "d:2147483648:dir", "g:h:rewire"), Std.string(params).split(","));
	}

	public function initWithSeedTest():Void {
		var params:ArpParams = new ArpParams();
		params.initWithSeed(ArpSeed.fromXmlString("<params>a:b,c:10,d:2147483648:dir,g:h:rewire,faceValue</params>"));
		assertEquals("b", params["a"]);
		assertEquals(10, params["c"]);
		assertEquals(ArpDirection.LEFT.value, params["d"].value);
		assertEquals("h", params[".g"].rewireFrom);
		assertEquals("faceValue", params["face"]);
	}

	public function testClone():Void {
		var params:ArpParams = new ArpParams();
		params["a"] = "b";
		params["c"] = 10;
		params["d"] = ArpDirection.LEFT;
		params["g"] = new ArpParamRewire("h");
		var params2:ArpParams = params.clone();
		assertEquals(params["a"], params2["a"]);
		assertEquals(params["c"], params2["c"]);
		assertEquals(params["d"].value, params2["d"].value);
		assertEquals("h", params["g"].rewireFrom);
	}

	public function testCopyFrom():Void {
		var params:ArpParams = new ArpParams();
		params["a"] = "b";
		params["c"] = 10;
		params["d"] = ArpDirection.LEFT;
		params["g"] = new ArpParamRewire("h");
		var params2:ArpParams = new ArpParams().addParam("e", "f").copyFrom(params);
		assertEquals(params["a"], params2["a"]);
		assertEquals(params["c"], params2["c"]);
		assertEquals(params["d"].value, params2["d"].value);
		assertEquals(params["g"].rewireFrom, params2["g"].rewireFrom);
	}

	/*
	public function testPersist():Void {
		var params : ArpParams = new ArpParams();
		params["a"] = "b";
		params["c"] = 10;
		params["d"] = ArpDirection.LEFT;
		params["g"] = new ArpParamRewire("h");
		var params2 : ArpParams = new ArpParams();
		var bytes : ByteArray = new ByteArray();
		params.writeSelf(new TaggedPersistOutput(bytes));
		bytes.position = 0;
		params2.readSelf(new TaggedPersistInput(bytes));
		assertEquals(params["a"], params2["a"]);
		assertEquals(params[".c"], params2["c"]);
		assertEquals(params["d"].value, params2["d"].value);
		assertEquals(params["g"].rewireFrom, params2["g"].rewireFrom);
	}
	*/
}


