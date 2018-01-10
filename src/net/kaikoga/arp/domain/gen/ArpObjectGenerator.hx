package net.kaikoga.arp.domain.gen;

import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;

class ArpObjectGenerator<T:IArpObject> {

	private var nativeClass:Class<T>;
	private var arpTypeInfo:ArpTypeInfo;
	public var isDefault(default, null):Bool;

	public var arpType(get, never):ArpType;
	private function get_arpType():ArpType return this.arpTypeInfo.arpType;
	public var className(get, never):String;
	private function get_className():String return this.arpTypeInfo.name;

	public function new(nativeClass:Class<T>, forceDefault:Null<Bool> = null) {
		this.nativeClass = nativeClass;
		this.arpTypeInfo = Type.createEmptyInstance(nativeClass).arpTypeInfo;
		this.isDefault = (forceDefault != null) ? forceDefault : this.className == this.arpType.toString();
	}

	public function matchSeed(seed:ArpSeed, type:ArpType, className:String):Bool {
		if (type != this.arpType) return false;
		return className == this.className;
	}

	public function alloc(seed:ArpSeed):T {
		return Type.createInstance(nativeClass, []);
	}
}
