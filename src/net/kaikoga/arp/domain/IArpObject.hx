package net.kaikoga.arp.domain;

import net.kaikoga.arp.persistable.IPersistable;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
import net.kaikoga.arp.domain.core.ArpType;

interface IArpObject extends IPersistable {

	var arpDomain(get, never):ArpDomain;
	var arpType(get, never):ArpType;
	function arpTypeInfo():ArpTypeInfo;
	function arpSlot():ArpUntypedSlot;
	function arpInit(slot:ArpUntypedSlot, seed:ArpSeed = null):IArpObject;
	function arpDispose():Void;
	function arpClone():IArpObject;
	function arpCopyFrom(source:IArpObject):IArpObject;

	function arpHeatLater():Void;
	function arpHeatUp():Bool;
	function arpHeatDown():Bool;
}
