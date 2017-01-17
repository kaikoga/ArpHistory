package net.kaikoga.arp.domain.gen;

import net.kaikoga.arp.domain.core.ArpType;

interface IArpLateGenerator<T:IArpObject> {
	function arpType():ArpType;

	function matchDir(dir:ArpDirectory, type:ArpType, className:String):Bool;
	function allocLate(dir:ArpDirectory, type:ArpType):T;
}
