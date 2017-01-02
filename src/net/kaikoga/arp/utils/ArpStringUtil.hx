package net.kaikoga.arp.utils;

class ArpStringUtil {
	inline public static function isNumeric(value:String):Bool {
		return if (value != null) ~/^[-+.0-9]+$/.match(value) else false;
	}

	public static function parseHex(str:String):Int {
		var value:Int = 0;
		for (i in 0...str.length) {
			switch (str.charCodeAt(i)) {
				case n if (n >= 48 && n < 58): value = (value << 4) + n - 48;
				case a if (a >= 65 && a < 71): value = (value << 4) + a - 55;
				case a if (a >= 97 && a < 103): value = (value << 4) + a - 87;
				case c: throw 'invalid character $c';
			}
		}
		return value;
	}

	inline public static function parseFloatDefault(string:String, defaultValue:Float):Float {
		var value:Float = Std.parseFloat(string);
		return Math.isNaN(value) ? defaultValue : value;
	}

	public static function parseRichFloat(str:String, getUnit:String->Float):Float {
		if (str == null) return 0.0;
		var value:Float = 0.0;
		var ereg:EReg = ~/([-+]?(?:[0-9]+\.?[0-9]*)|(?:\.[0-9]+))([a-zA-Z]*)/;
		var pos = 0;
		while (ereg.matchSub(str, pos)) {
			pos += ereg.matchedPos().len;
			var coefficient:Float = Std.parseFloat(ereg.matched(1));
			var unit:String = ereg.matched(2);
			if (unit == "e") {
				if (ereg.matchSub(str, pos)) {
					pos += ereg.matchedPos().len;
					coefficient *= Math.pow(10, Std.parseFloat(ereg.matched(1)));
					unit = ereg.matched(2);
				}
			}
			value += coefficient * getUnit(unit);
		}
		return value;
	}
}
