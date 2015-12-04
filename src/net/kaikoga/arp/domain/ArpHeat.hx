package net.kaikoga.arp.domain;

@:enum abstract ArpHeat(Int) {
	var Cold = 1;
	var Warming = 2;
	var Warm = 3;
}
