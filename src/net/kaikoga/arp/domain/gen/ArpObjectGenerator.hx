package net.kaikoga.arp.domain.gen;

import net.kaikoga.arp.domain.core.ArpType;

class ArpObjectGenerator<T:IArpObject> extends ArpDynamicGenerator<T> {

	public function new(dest:Class<T>, forceDefault:Null<Bool> = null) {
		var arpTypeInfo:ArpTypeInfo = Type.createEmptyInstance(dest).arpTypeInfo;
		super(arpTypeInfo.arpType, dest, arpTypeInfo.name, (forceDefault != null) ? forceDefault : arpTypeInfo.isDefault());
	}

}