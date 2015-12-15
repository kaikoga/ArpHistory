package net.kaikoga.arp.domain.gen;

import net.kaikoga.arp.domain.core.ArpType;

interface IArpLateGenerator<T:IArpObject> {
	function arpType():ArpType;

	function matchDir(dir:ArpDirectory, type:ArpType, template:String):Bool;
	function allocLate(dir:ArpDirectory, type:ArpType):T;
}
