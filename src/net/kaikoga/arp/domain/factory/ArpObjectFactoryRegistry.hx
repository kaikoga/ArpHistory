package net.kaikoga.arp.domain.factory;

import net.kaikoga.arp.ds.lambda.SetOp;
import net.kaikoga.arp.ds.impl.ArraySet;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;

class ArpObjectFactoryRegistry {

	private var factories:ArpObjectFactoryListMap;

	public function new() {
		this.factories = new ArpObjectFactoryListMap();
	}

	public function addTemplate<T:IArpObject>(klass:Class<T>, forceDefault:Null<Bool> = null) {
		var factory:ArpObjectFactory<T> = new ArpObjectFactory<T>(klass, forceDefault);
		this.factories.listFor(factory.arpType).push(factory);
	}

	public function resolve<T:IArpObject>(seed:ArpSeed, type:ArpType):ArpObjectFactory<T> {
		var className = seed.className;
		if (className == null) className = seed.env.getDefaultClass(type.toString());
		var result:ArpObjectFactory<Dynamic> = null;
		var resultMatch:Float = 0;
		for (factory in this.factories.listFor(type)) {
			var match:Float = factory.matchSeed(seed, type, className);
			if (match > resultMatch) {
				result = factory;
				resultMatch = match;
			}
		}
		if (result == null) {
			throw 'factory not found for <$type>: class=${seed.className}';
		}
		return cast result;
	}

	public function allArpTypes():Array<ArpType> {
		var result:ArraySet<ArpType> = new ArraySet();
		for (arpType in this.factories.allArpTypes()) result.add(arpType);
		return SetOp.toArray(result);
	}

}

private class ArpObjectFactoryListMap {

	private var map:Map<String, Array<ArpObjectFactory<Dynamic>>>;

	public function new() {
		this.map = new Map();
	}

	public function listFor(type:ArpType):Array<ArpObjectFactory<Dynamic>> {
		var t:String = type.toString();
		if (this.map.exists(t)) return this.map.get(t);
		var a:Array<ArpObjectFactory<Dynamic>> = [];
		this.map.set(t, a);
		return a;
	}

	public function allArpTypes():Array<ArpType> {
		return [for (arpType in this.map.keys()) new ArpType(arpType)];
	}
}