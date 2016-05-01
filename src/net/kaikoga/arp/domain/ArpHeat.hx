package net.kaikoga.arp.domain;

@:enum abstract ArpHeat(Int) {
	var Cold = 1;
	var Warming = 2;
	var Warm = 3;

	@:op(a > b) static function opGt( a:ArpHeat, b:ArpHeat):Bool;
	@:op(a < b) static function opLt( a:ArpHeat, b:ArpHeat):Bool;
	@:op(a >= b) static function opGte( a:ArpHeat, b:ArpHeat):Bool;
	@:op(a <= b) static function opLte( a:ArpHeat, b:ArpHeat):Bool;
	@:op(a == b) static function opEq( a:ArpHeat, b:ArpHeat):Bool;
	@:op(a != b) static function opNeq( a:ArpHeat, b:ArpHeat):Bool;

	public static function fromName(name:String):ArpHeat {
		return switch (name) {
			case "cold": ArpHeat.Cold;
			case "warming": ArpHeat.Warming;
			case "warm": ArpHeat.Warm;
			default: ArpHeat.Cold;
		}
	}

	public function toName():String {
		return switch (this) {
			case ArpHeat.Cold: "cold";
			case ArpHeat.Warming: "warming";
			case ArpHeat.Warm: "warm";
			default: "?invalid?";
		}
	}

	public function toChar():String {
		return switch (this) {
			case ArpHeat.Cold: "-";
			case ArpHeat.Warming: "*";
			case ArpHeat.Warm: "+";
			default: "?";
		}
	}
}
