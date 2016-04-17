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
}
