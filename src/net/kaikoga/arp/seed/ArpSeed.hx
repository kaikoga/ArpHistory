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
	private var _isSimple:Bool;

	private var _children:Array<ArpSeed>;

	private function new(kind:ArpSeedKind, typeName:String, className:String, name:String, heat:String, key:String, value:String, env:ArpSeedEnv, explicitChildren:Array<ArpSeed>) {
		this.kind = kind;
		this._typeName = typeName;
		this._className = className;
		this._name = name;
		this._heat = heat;
		this._key = key;
		this._value = value;
		this._env = env;
		if (explicitChildren != null) this.createChildren(explicitChildren);
		this._isSimple = explicitChildren == null;
	}

	private function createChildren(explicitChildren:Array<ArpSeed>):Void {
		this._children = explicitChildren;
		if (this._value != null) this._children.push(simpleValue("value", "$$", this._value, null));
	}

	inline public function typeName():String return this._typeName;
	inline public function className():String return this._className;
	inline public function name():String return this._name;
	inline public function ref():String return switch (this.kind) { case ArpSeedKind.SimpleRefValue: this._value; case _: null; };
	inline public function heat():String return this._heat;
	inline public function key():String return this._key;
	inline public function value():String return this._value;
	inline public function env():ArpSeedEnv return this._env;
	inline public function isSimple():Bool return this._isSimple;

	public function iterator():Iterator<ArpSeed> {
		if (this._children == null) this.createChildren([]);
		return this._children.iterator();
	}

	inline public static function maybeComplex(typeName:String, className:String, name:String, heat:String, key:String, value:String, env:ArpSeedEnv, explicitChildren:Array<ArpSeed>):ArpSeed {
		return new ArpSeed(ArpSeedKind.Complex, typeName, className, name, heat, key, value, env, explicitChildren);
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
	Complex;
}
