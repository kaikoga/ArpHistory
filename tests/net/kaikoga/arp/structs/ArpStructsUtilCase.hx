package net.kaikoga.arp.structs;

import picotest.PicoAssert.*;

class ArpStructsUtilCase {

	inline public static function testIsNumeric():Void {
		assertTrue(ArpStructsUtil.isNumeric(""));
		assertTrue(ArpStructsUtil.isNumeric("0"));
		assertTrue(ArpStructsUtil.isNumeric("123456789"));
		assertTrue(ArpStructsUtil.isNumeric("00001234"));
		assertTrue(ArpStructsUtil.isNumeric("0.123"));
		assertTrue(ArpStructsUtil.isNumeric(".25"));
		assertTrue(ArpStructsUtil.isNumeric("-0.456"));
		assertTrue(ArpStructsUtil.isNumeric(".78"));
		assertTrue(ArpStructsUtil.isNumeric("+5"));
		assertFalse(ArpStructsUtil.isNumeric("1e37"));
		assertFalse(ArpStructsUtil.isNumeric("NaN"));
		assertFalse(ArpStructsUtil.isNumeric("Infinity"));
		assertFalse(ArpStructsUtil.isNumeric("infinity"));
		assertFalse(ArpStructsUtil.isNumeric("inf"));
		assertFalse(ArpStructsUtil.isNumeric("Inf"));
		assertFalse(ArpStructsUtil.isNumeric("null"));
		assertFalse(ArpStructsUtil.isNumeric("undefined"));
		assertFalse(ArpStructsUtil.isNumeric(null));
	}

	public static function testParseHex():Void {
		assertEquals(0x0, ArpStructsUtil.parseHex(""));
		assertEquals(0x0, ArpStructsUtil.parseHex("0"));
		assertEquals(0x1, ArpStructsUtil.parseHex("1"));
		assertEquals(0x9, ArpStructsUtil.parseHex("9"));
		assertEquals(0xa, ArpStructsUtil.parseHex("a"));
		assertEquals(0xf, ArpStructsUtil.parseHex("f"));
		assertEquals(0xa, ArpStructsUtil.parseHex("A"));
		assertEquals(0xf, ArpStructsUtil.parseHex("F"));
		assertEquals(0x3f, ArpStructsUtil.parseHex("3f"));
		assertEquals(0x7af7af, ArpStructsUtil.parseHex("7aF7Af"));
	}

	inline public static function testParseFloatDefault():Void {
		assertEquals(0.0, ArpStructsUtil.parseFloatDefault("0.0", 0.0));
		assertEquals(1.0, ArpStructsUtil.parseFloatDefault("1.0", 2.0));
		assertEquals(2.0, ArpStructsUtil.parseFloatDefault("nan", 2.0));
		assertEquals(2.0, ArpStructsUtil.parseFloatDefault("", 2.0));
		assertEquals(2.0, ArpStructsUtil.parseFloatDefault(null, 2.0));
	}
}
