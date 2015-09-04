package net.kaikoga.arp.domain.gen;

import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.seed.ArpSeed;

interface IArpGenerator<T:IArpObject> {
	function arpType():ArpType;

	function matchSeed(seed:ArpSeed, type:ArpType):Bool;
	function alloc(seed:ArpSeed):T;
}
