package net.kaikoga.arp.domain.reflect;

import net.kaikoga.arp.domain.core.ArpType;

enum ArpFieldType {
	PrimInt(t:ArpType);
	PrimFloat(t:ArpType);
	PrimBool(t:ArpType);
	PrimString(t:ArpType);
	StructType(t:ArpType);
	ReferenceType(t:ArpType);
}

