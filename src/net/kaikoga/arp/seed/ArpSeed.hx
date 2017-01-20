package net.kaikoga.arp.seed;

import haxe.io.Bytes;
import Xml.XmlType;

class ArpSeed {

	inline private static var AUTO_HEADER:String = "$";

	private var kind:ArpSeedKind;
	private var _typeName:String;
	private var _className:String;
	private var _name:String;
	private var _heat:String;
	private var _key:String;
	private var _value:String;
	private var _env:ArpSeedEnv;

	private var _children:Array<ArpSeed>;
	private static var emptyChildren:Array<ArpSeed> = [];

	private function new(kind:ArpSeedKind, typeName:String, className:String, name:String, heat:String, key:String, value:String, env:ArpSeedEnv, children:Array<ArpSeed>) {
		this.kind = kind;
		this._typeName = typeName;
		this._className = className;
		this._name = name;
		this._heat = heat;
		this._key = key;
		this._value = value;
		this._env = env;
		this._children = (children != null) ? children : emptyChildren;
	}

	inline public function typeName():String return this._typeName;
	inline public function className():String return this._className;
	inline public function name():String return this._name;
	inline public function ref():String return switch (this.kind) { case ArpSeedKind.SimpleRefValue: this._value; case _: null; };
	inline public function heat():String return this._heat;
	inline public function key():String return this._key;
	inline public function value():String return this._value;
	inline public function env():ArpSeedEnv return this._env;
	inline public function isSimple():Bool return switch (this.kind) { case ArpSeedKind.Complex: false; case _: true; };

	inline public function iterator():Iterator<ArpSeed> {
		switch (this.kind) {
			case ArpSeedKind.Complex:
				return this._children.iterator();
			case _:
				if (this._value == null) return emptyChildren.iterator();
				return [ArpSeed.simpleValue("value", "$$", this._value, this._env)].iterator();
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

private enum ArpSeedKind {
	SimpleValue;
	SimpleRefValue;
	SimpleObject;
	Complex;
}
