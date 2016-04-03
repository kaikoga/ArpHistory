package net.kaikoga.arp.structs;

import haxe.io.BytesOutput;
import net.kaikoga.arp.persistable.TaggedPersistOutput;
import net.kaikoga.arp.io.OutputWrapper;
import net.kaikoga.arp.persistable.TaggedPersistInput;
import net.kaikoga.arp.io.InputWrapper;
import haxe.io.BytesInput;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.structs.ArpParams;

import org.hamcrest.Matchers;
import picotest.PicoAssert.*;

class ArpParamsCase {

	public function testAddParam():Void {
		var params:ArpParamsProxy = new ArpParams();
		params["a"] = "b";
		params["c"] = 10;
		params["d"] = ArpDirection.LEFT;
		params.set("e", "f");
		params["g"] = new ArpParamRewire("h");
		assertEquals("b", params["a"]);
		assertEquals(10, params["c"]);
		assertEquals(ArpDirection.LEFT.value, params["d"].value);
		assertEquals("f", params["e"]);
		assertEquals("h", params["g"].rewireFrom);
	}

	public function testToString():Void {
		var params:ArpParamsProxy = new ArpParams();
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
		var params:ArpParamsProxy = new ArpParams();
		params.initWithSeed(ArpSeed.fromXmlString("<params>a:b,c:10,d:2147483648:dir,g:h:rewire,faceValue</params>"));
		assertEquals("b", params["a"]);
		assertEquals(10, params["c"]);
		assertEquals(ArpDirection.LEFT.value, params["d"].value);
		assertEquals("h", params[".g"].rewireFrom);
		assertEquals("faceValue", params["face"]);
	}

	public function testClone():Void {
		var params:ArpParamsProxy = new ArpParams();
		params["a"] = "b";
		params["c"] = 10;
		params["d"] = ArpDirection.LEFT;
		params["g"] = new ArpParamRewire("h");
		var params2:ArpParamsProxy = params.clone();
		assertEquals(params["a"], params2["a"]);
		assertEquals(params["c"], params2["c"]);
		assertEquals(params["d"].value, params2["d"].value);
		assertEquals("h", params["g"].rewireFrom);
	}

	public function testCopyFrom():Void {
		var params:ArpParamsProxy = new ArpParams();
		params["a"] = "b";
		params["c"] = 10;
		params["d"] = ArpDirection.LEFT;
		params["g"] = new ArpParamRewire("h");
		var params2:ArpParamsProxy = new ArpParams().copyFrom(params);
		assertEquals(params["a"], params2["a"]);
		assertEquals(params["c"], params2["c"]);
		assertEquals(params["d"].value, params2["d"].value);
		assertEquals(params["g"].rewireFrom, params2["g"].rewireFrom);
	}

	public function testPersist():Void {
		var params:ArpParamsProxy = new ArpParams();
		params["a"] = "b";
		params["c"] = 10;
		params["d"] = ArpDirection.LEFT;
		params["g"] = new ArpParamRewire("h");
		var params2:ArpParamsProxy = new ArpParams();
		var bytesOutput:BytesOutput = new BytesOutput();
		params.writeSelf(new TaggedPersistOutput(new OutputWrapper(bytesOutput)));
		params2.readSelf(new TaggedPersistInput(new InputWrapper(new BytesInput(bytesOutput.getBytes()))));
		assertEquals(params["a"], params2["a"]);
		assertEquals(params["c"], params2["c"]);
		assertEquals(params["d"].value, params2["d"].value);
		assertEquals(params["g"].rewireFrom, params2["g"].rewireFrom);
	}
}

