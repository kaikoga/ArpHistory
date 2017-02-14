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
	public var env(default, null):ArpSeedEnv;

	public var value(get, never):String;
	public var valueKind(get, never):ArpSeedValueKind;
	public var isSimple(get, never):Bool;

	private function new(typeName:String, className:String, name:String, heat:String, key:String, env:ArpSeedEnv) {
		this.typeName = typeName;
		this.className = className;
		this.name = name;
		this.heat = heat;
		this.key = key;
		this.env = env;
	}

	private function get_valueKind():ArpSeedValueKind throw "not implemented";
	private function get_value():String throw "not implemented";
	private function get_isSimple():Bool throw "not implemented";

	public function iterator():Iterator<ArpSeed> throw "not implemented";

	// @:access(net.kaikoga.arp.seed.impl.ArpSeedComplex.new)
	inline public static function complex(typeName:String, className:String, name:String, heat:String, key:String, children:Array<ArpSeed>, env:ArpSeedEnv):ArpSeed {
		return new ArpSeedComplex(typeName, className, name, heat, key, children, env);
	}

	// @:access(net.kaikoga.arp.seed.impl.ArpSeedSimpleObject.new)
	inline public static function simpleObject(typeName:String, className:String, name:String, heat:String, key:String, value:String, env:ArpSeedEnv):ArpSeed {
		return new ArpSeedSimpleObject(typeName, className, name, heat, key, value, env);
	}

	// @:access(net.kaikoga.arp.seed.impl.ArpSeedSimpleRefValue.new)
	inline public static function simpleRefValue(typeName:String, key:String, value:String, env:ArpSeedEnv):ArpSeed {
		return new ArpSeedSimpleRefValue(typeName, key, value, env);
	}

	// @:access(net.kaikoga.arp.seed.impl.ArpSeedSimpleValue.new)
	inline public static function simpleValue(typeName:String, key:String, value:String, env:ArpSeedEnv):ArpSeed {
		return new ArpSeedSimpleValue(typeName, key, value, env);
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
