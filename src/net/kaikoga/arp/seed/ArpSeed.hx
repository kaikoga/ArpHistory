package net.kaikoga.arp.seed;

import haxe.io.Bytes;
import Xml.XmlType;

class ArpSeed {

	inline private static var AUTO_HEADER:String = "$";

	private var _typeName:String;
	private var _name:String;
	private var _ref:String;
	private var _template:String;
	private var _heat:String;
	private var _key:String;
	private var _value:String;
	private var _env:ArpSeedEnv;
	private var _children:Array<ArpSeed>;
	private var _isSimple:Bool;

	private function new(typeName:String, template:String, name:String, ref:String, heat:String, key:String, value:String, env:ArpSeedEnv, explicitChildren:Array<ArpSeed>) {
		this._typeName = typeName;
		this._template = template;
		this._name = name;
		this._ref = ref;
		this._heat = heat;
		this._key = key;
		this._value = value;
		this._env = env;
		if (explicitChildren != null) this.createChildren(explicitChildren);
		this._isSimple = explicitChildren == null;
	}

	private function createChildren(explicitChildren:Array<ArpSeed>):Void {
		this._children = explicitChildren;
		if (this._value != null) this._children.push(simpleValue("value", this._value, null));
	}

	inline public function typeName():String return this._typeName;
	inline public function template():String return this._template;
	inline public function name():String return this._name;
	inline public function ref():String return this._ref;
	inline public function heat():String return this._heat;
	inline public function key(uniqId:Int):String {
		return if (this._key != null) this._key else Std.string(AUTO_HEADER + uniqId);
	}
	inline public function value():String return this._value;
	inline public function env():ArpSeedEnv return this._env;
	inline public function isSimple():Bool return this._isSimple;

	public function iterator():Iterator<ArpSeed> {
		if (this._children == null) this.createChildren([]);
		return this._children.iterator();
	}

	inline public static function complex(typeName:String, template:String, name:String, ref:String, heat:String, key:String, value:String, env:ArpSeedEnv, explicitChildren:Array<ArpSeed>):ArpSeed {
		return new ArpSeed(typeName, template, name, ref, heat, key, value, env, explicitChildren);
	}

	inline public static function simpleRefValue(typeName:String, value:String, env:ArpSeedEnv):ArpSeed {
		return new ArpSeed(typeName, null, null, value, null, null, value, env, null);
	}

	inline public static function simpleValue(typeName:String, value:String, env:ArpSeedEnv):ArpSeed {
		return new ArpSeed(typeName, null, null, null, null, null, value, env, null);
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
