package arp.seed;

import haxe.io.Bytes;
import Xml.XmlType;

class ArpSeed {

	public var typeName(default, null):String;
	public var key(default, null):String;
	public var env(default, null):ArpSeedEnv;

	public var value(get, never):String;
	public var valueKind(get, never):ArpSeedValueKind;
	public var isSimple(get, never):Bool;

	public var className(get, never):String;
	public var name(get, never):String;
	public var heat(get, never):String;
	public function iterator():Iterator<ArpSeed> throw "not implemented";

	private function new(typeName:String) {
		this.typeName = typeName;
	}

	private function get_value():String throw "not implemented";
	private function get_valueKind():ArpSeedValueKind throw "not implemented";
	private function get_isSimple():Bool throw "not implemented";

	private function get_className():String throw "not implemented";
	private function get_name():String throw "not implemented";
	private function get_heat():String throw "not implemented";

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
