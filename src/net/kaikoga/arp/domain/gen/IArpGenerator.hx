package net.kaikoga.arp.domain.gen;

import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.seed.ArpSeed;

interface IArpGenerator<T:IArpObject> {
	var arpType(get, never):ArpType;
	var template(get, never):Null<String>;
	var isDefault(get, never):Bool;

	function matchSeed(seed:ArpSeed, type:ArpType, template:String):Bool;
	function alloc(seed:ArpSeed):T;
}
