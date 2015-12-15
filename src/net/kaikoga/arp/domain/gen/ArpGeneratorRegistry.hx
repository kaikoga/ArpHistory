package net.kaikoga.arp.domain.gen;

import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;

class ArpGeneratorRegistry {

	private var genMap:ArpGeneratorListMap;
	private var defaultGenMap:ArpGeneratorListMap;

	public function new() {
		this.genMap = new ArpGeneratorListMap();
		this.defaultGenMap = new ArpGeneratorListMap();
	}

	public function addGenerator<T:IArpObject>(gen:IArpGenerator<T>) {
		this.genMap.listFor(gen.arpType).push(gen);
	}

	public function addDefaultGenerator<T:IArpObject>(gen:IArpGenerator<T>) {
		// also add as normal generator
		if (gen.template != null) this.genMap.listFor(gen.arpType).push(gen);
		this.defaultGenMap.listFor(gen.arpType).push(gen);
	}

	public function resolve<T:IArpObject>(seed:ArpSeed, type:ArpType):IArpGenerator<T> {
		for (gen in this.genMap.listFor(type)) {
			if (gen.matchSeed(seed, type, seed.template())) return cast gen;
		}
		for (gen in this.defaultGenMap.listFor(type)) {
			if (gen.matchSeed(seed, type, gen.template)) return cast gen;
		}
		return null;
	}

}

private class ArpGeneratorListMap {

	private var map:Map<String, Array<IArpGenerator<Dynamic>>>;

	public function new() {
		this.map = new Map();
	}

	public function listFor(type:ArpType):Array<IArpGenerator<Dynamic>> {
		var t:String = type.toString();
		if (this.map.exists(t)) return this.map.get(t);
		var a:Array<IArpGenerator<Dynamic>> = [];
		this.map.set(t, a);
		return a;
	}

}
