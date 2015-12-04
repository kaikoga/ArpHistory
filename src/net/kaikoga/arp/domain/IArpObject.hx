package net.kaikoga.arp.domain;

import net.kaikoga.arp.persistable.IPersistable;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
import net.kaikoga.arp.domain.core.ArpType;

interface IArpObject extends IPersistable {

	function arpDomain():ArpDomain;
	function arpType():ArpType;
	function arpSlot():ArpUntypedSlot;
	function arpInit(slot:ArpUntypedSlot, seed:ArpSeed = null):IArpObject;
	function arpDispose():Void;

	function arpHeatLater():Void;
	function arpHeatUp():Bool;
	function arpHeatDown():Bool;

	// function init():Void;
	// function heatUp():Bool;
	// function heatDown():Bool;
	// function dispose():Void;
}
