package arp.seed;

import haxe.io.Bytes;
import Xml.XmlType;

class ArpSeed {

	/*
		ArpSeed implementations:
		- Plain values:
		  - ArpSeedSimpleReferenceValue is Reference
		  - ArpSeedSimpleAmbigiousValue is Ambigious
		  - ArpSeedSimpleLiteralValue is Literal
		- Complex values (all of them are Literal):
		  - ArpSeedSimpleObject has single child
		  - ArpSeedComplex has children
		- ArpSeedRawValue is used when iterating simple ArpSeed (they are treated as Literal)
	 */

	private var element:ArpSeedElement;

	public var typeName(default, null):String;

	public var className(get, never):String;
	inline private function get_className():String return if (element != null) element.className else null;
	public var name(get, never):String;
	inline private function get_name():String return if (element != null) element.name else null;
	public var heat(get, never):String;
	inline private function get_heat():String return if (element != null) element.heat else null;

	public var key(get, never):String;
	public var value(get, never):String;
	public var env(get, never):ArpSeedEnv;
	public var valueKind(get, never):ArpSeedValueKind;
	public var isSimple(get, never):Bool;

	private function new(typeName:String, element:ArpSeedElement = null) {
		this.typeName = typeName;
		this.element = element;
	}

	private function get_key():String throw "not implemented";
	private function get_value():String throw "not implemented";
	private function get_env():ArpSeedEnv throw "not implemented";
	private function get_valueKind():ArpSeedValueKind throw "not implemented";
	private function get_isSimple():Bool throw "not implemented";

	public function iterator():Iterator<ArpSeed> throw "not implemented";

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
