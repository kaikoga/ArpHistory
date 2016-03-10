package net.kaikoga.arpx.camera;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.shadow.IShadow;
import net.kaikoga.arp.domain.IArpObject;

interface ICamera extends IArpObject
{
	var shadow(get, set):IShadow;
	var position(get, set):ArpPosition;
}
