package net.kaikoga.arp.seed;

import net.kaikoga.arp.seed.impl.ArpSeedKind;
import haxe.io.Bytes;
import Xml.XmlType;

class ArpSeed {

	inline private static var AUTO_HEADER:String = "$";

	private var kind:ArpSeedKind;
	public var typeName(default, null):String;
	public var className(default, null):String;
	public var name(default, null):String;
	public var heat(default, null):String;
	public var key(default, null):String;
	public var value(default, null):String;
	public var env(default, null):ArpSeedEnv;

	public var ref(get, never):String;
	public var isSimple(get, never):Bool;

	private var children:Array<ArpSeed>;
	private static var emptyChildren:Array<ArpSeed> = [];

	private function new(kind:ArpSeedKind, typeName:String, className:String, name:String, heat:String, key:String, value:String, env:ArpSeedEnv, children:Array<ArpSeed>) {
		this.kind = kind;
		this.typeName = typeName;
		this.className = className;
		this.name = name;
		this.heat = heat;
		this.key = key;
		this.value = value;
		this.env = env;
		this.children = (children != null) ? children : emptyChildren;
	}

	private function get_ref():String return switch (this.kind) { case ArpSeedKind.SimpleRefValue: this.value; case _: null; };
	private function get_isSimple():Bool return switch (this.kind) { case ArpSeedKind.Complex: false; case _: true; };

	public function iterator():Iterator<ArpSeed> {
		switch (this.kind) {
			case ArpSeedKind.Complex:
				return this.children.iterator();
			case _:
				if (this.value == null) return emptyChildren.iterator();
				return [ArpSeed.simpleValue("value", "$$", this.value, this.env)].iterator();
		};
	}

	inline public static function complex(typeName:String, className:String, name:String, heat:String, key:String, children:Array<ArpSeed>, env:ArpSeedEnv):ArpSeed {
		return new ArpSeed(ArpSeedKind.Complex, typeName, className, name, heat, key, null, env, children);
	}

	inline public static function simpleObject(typeName:String, className:String, name:String, heat:String, key:String, value:String, env:ArpSeedEnv):ArpSeed {
		return new ArpSeed(ArpSeedKind.SimpleObject, typeName, className, name, heat, key, value, env, null);
	}

	inline public static function simpleRefValue(typeName:String, key:String, value:String, env:ArpSeedEnv):ArpSeed {
		return new ArpSeed(ArpSeedKind.SimpleRefValue, typeName, null, null, null, key, value, env, null);
	}

	inline public static function simpleValue(typeName:String, key:String, value:String, env:ArpSeedEnv):ArpSeed {
		return new ArpSeed(ArpSeedKind.SimpleValue, typeName, null, null, null, key, value, env, null);
	}

	inline public static function fromXmlBytes(bytes:Bytes, env:ArpSeedEnv = null):ArpSeed {
		return new ArpXmlSeedReader().parseXmlBytes(bytes, env);
	}

	inline public static function fromXmlString(xmlString:String, env:ArpSeedEnv = null):ArpSeed {
		return new ArpXmlSeedReader().parseXmlString(xmlString, env);
	}

	public static function fromXml(xml:Xml, env:ArpSeedEnv = null):ArpSeed {
		return new ArpXmlSeedReader().parse(xml, env);
	}
}
