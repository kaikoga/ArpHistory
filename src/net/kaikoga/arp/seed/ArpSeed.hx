package net.kaikoga.arp.seed;

import net.kaikoga.arp.seed.impl.ArpSeedComplex;
import net.kaikoga.arp.seed.impl.ArpSeedSimpleObject;
import net.kaikoga.arp.seed.impl.ArpSeedSimpleRefValue;
import net.kaikoga.arp.seed.impl.ArpSeedSimpleValue;
import haxe.io.Bytes;
import Xml.XmlType;

class ArpSeed {

	public var typeName(default, null):String;
	public var className(default, null):String;
	public var name(default, null):String;
	public var heat(default, null):String;
	public var key(default, null):String;
	public var value(default, null):String;
	public var env(default, null):ArpSeedEnv;

	public var kind(get, never):ArpSeedKind;
	public var ref(get, never):String;
	public var isSimple(get, never):Bool;

	private var children:Array<ArpSeed>;
	private static var emptyChildren:Array<ArpSeed> = [];

	private function new(typeName:String, className:String, name:String, heat:String, key:String, value:String, env:ArpSeedEnv, children:Array<ArpSeed>) {
		this.typeName = typeName;
		this.className = className;
		this.name = name;
		this.heat = heat;
		this.key = key;
		this.value = value;
		this.env = env;
		this.children = (children != null) ? children : emptyChildren;
	}

	private function get_kind():ArpSeedKind throw "not implemented";
	private function get_ref():String throw "not implemented";
	private function get_isSimple():Bool throw "not implemented";

	public function iterator():Iterator<ArpSeed> throw "not implemented";

	@:access(net.kaikoga.arp.seed.impl.ArpSeedComplex.new)
	inline public static function complex(typeName:String, className:String, name:String, heat:String, key:String, children:Array<ArpSeed>, env:ArpSeedEnv):ArpSeed {
		return new ArpSeedComplex(typeName, className, name, heat, key, null, env, children);
	}

	@:access(net.kaikoga.arp.seed.impl.ArpSeedComplex.new)
	inline public static function simpleObject(typeName:String, className:String, name:String, heat:String, key:String, value:String, env:ArpSeedEnv):ArpSeed {
		return new ArpSeedSimpleObject(typeName, className, name, heat, key, value, env, null);
	}

	@:access(net.kaikoga.arp.seed.impl.ArpSeedComplex.new)
	inline public static function simpleRefValue(typeName:String, key:String, value:String, env:ArpSeedEnv):ArpSeed {
		return new ArpSeedSimpleRefValue(typeName, null, null, null, key, value, env, null);
	}

	@:access(net.kaikoga.arp.seed.impl.ArpSeedComplex.new)
	inline public static function simpleValue(typeName:String, key:String, value:String, env:ArpSeedEnv):ArpSeed {
		return new ArpSeedSimpleValue(typeName, null, null, null, key, value, env, null);
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
