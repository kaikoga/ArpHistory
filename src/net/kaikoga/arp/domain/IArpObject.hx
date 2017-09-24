package net.kaikoga.arp.domain;

import net.kaikoga.arp.domain.ArpUntypedSlot;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.persistable.IPersistable;
import net.kaikoga.arp.seed.ArpSeed;

#if !macro
@:autoBuild(net.kaikoga.arp.ArpDomainMacros.autoBuildObject())
#end
interface IArpObject extends IPersistable /* extends IArpObjectImpl */ {

	var arpDomain(get, never):ArpDomain;
	var arpType(get, never):ArpType;
	var arpTypeInfo(get, never):ArpTypeInfo;
	var arpSlot(get, never):ArpUntypedSlot;

	function arpInit(slot:ArpUntypedSlot, seed:ArpSeed = null):IArpObject;
	function arpDispose():Void;
	function arpClone():IArpObject;
	function arpCopyFrom(source:IArpObject):IArpObject;

	function arpHeatLater():Void;
	function arpHeatUp():Bool;
	function arpHeatDown():Bool;
}
