package net.kaikoga.arp.domain.gen;

import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;

class ArpDynamicGenerator<T:IArpObject> implements IArpGenerator<T> {
	
	private var source:ArpType;
	private var dest:Class<T>;
	
	public function new(source:ArpType, dest:Class<T>) {
		this.source = source;
		this.dest = dest;
	}

	public function arpType():ArpType {
		return this.source;
	}

	public function matchSeed(seed:ArpSeed, type:ArpType):Bool {
		return type == this.source;
	}

	public function alloc(seed:ArpSeed):T {
		return Type.createInstance(dest, []);
	}
}
