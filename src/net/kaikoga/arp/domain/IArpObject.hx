package net.kaikoga.arp.domain;

import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
import net.kaikoga.arp.domain.core.ArpType;

interface IArpObject {
	function arpDomain():ArpDomain;
	function arpType():ArpType;
	function arpSlot():ArpUntypedSlot;
	function init(slot:ArpUntypedSlot, seed:ArpSeed = null):IArpObject;
}
