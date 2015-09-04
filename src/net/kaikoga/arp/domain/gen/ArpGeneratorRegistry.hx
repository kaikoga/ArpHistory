package net.kaikoga.arp.domain.gen;

import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;

class ArpGeneratorRegistry {
	
	private var genMap:Map<String, Array<IArpGenerator<Dynamic>>>;
	
	public function new() {
		this.genMap = new Map();
	}

	private function genList(type:ArpType):Array<IArpGenerator<Dynamic>> {
		var t:String = cast type;
		if (this.genMap.exists(t)) return this.genMap.get(t);
		var a:Array<IArpGenerator<Dynamic>> = [];
		this.genMap.set(t, a);
		return a;
	}

	public function addGenerator<T:IArpObject>(gen:IArpGenerator<T>) {
		this.genList(gen.arpType()).push(gen);
	}

	public function resolve<T:IArpObject>(seed:ArpSeed, type:ArpType):IArpGenerator<T> {
		for (gen in this.genList(type)) {
			if (gen.matchSeed(seed, type)) return cast gen;
		}
		return null;
	}

}
