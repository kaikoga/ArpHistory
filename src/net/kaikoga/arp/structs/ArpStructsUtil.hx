package net.kaikoga.arp.structs;

class ArpStructsUtil {
	inline public static function isNumeric(value:String):Bool {
		return ~/[-+.0-9]*/.match(value);
	}

	public static function parseHex(str:String):Int {
		var value:Int = 0;
		for (i in 0...str.length) {
			switch (str.charCodeAt(i)) {
				case n if (n >= 48 && n < 58): value = (value << 4) + n - 48;
				case a if (a >= 65 && a < 70): value = (value << 4) + a - 55;
				case a if (a >= 97 && a < 102): value = (value << 4) + a - 87;
				case c: throw 'invalid character $c';
			}
		}
		return value;
	}

	inline public static function parseFloatDefault(string:String, defaultValue:Float):Float {
		var value:Float = Std.parseFloat(string);
		return Math.isNaN(value) ? defaultValue : value;
	}
}
