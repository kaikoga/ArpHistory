package net.kaikoga.arp.domain.seed;

import haxe.io.Bytes;
import Xml.XmlType;

class ArpSeed {

	inline private static var AUTO_HEADER:String = "$";

	private var _typeName:String;
	private var _name:String;
	private var _ref:String;
	private var _template:String;
	private var _heat:ArpHeat;
	private var _key:String;
	private var _value:Dynamic;
	private var _children:Array<ArpSeed>;
	private var _isSimple:Bool;

	inline public function new(typeName:String, template:String, name:String, ref:String, heat:ArpHeat, key:String, value:Dynamic, explicitChildren:Array<ArpSeed>) {
		this._typeName = typeName;
		this._template = template;
		this._name = name;
		this._ref = ref;
		this._heat = heat;
		this._key = key;
		this._value = value;
		if (explicitChildren != null) this.createChildren(explicitChildren);
		this._isSimple = explicitChildren == null;
	}

	private function createChildren(explicitChildren:Array<ArpSeed>):Void {
		this._children = explicitChildren;
		if (this._value != null) this._children.push(simpleValue("value", this._value));
	}

	inline public function typeName():String return this._typeName;
	inline public function template():String return this._template;
	inline public function name():String return this._name;
	inline public function ref():String return this._ref;
	inline public function heat():ArpHeat return this._heat;
	inline public function key(uniqId:Int):String {
		return if (this._key != null) this._key else Std.string(AUTO_HEADER + uniqId);
	}
	inline public function value():Dynamic return this._value;
	inline public function isSimple():Bool return this._isSimple;

	public function iterator():Iterator<ArpSeed> {
		if (this._children == null) this.createChildren([]);
		return this._children.iterator();
	}

	inline public static function fromXmlBytes(bytes:Bytes):ArpSeed {
		return fromXmlString(bytes.toString());
	}

	inline public static function fromXmlString(xmlString:String):ArpSeed {
		return fromXml(Xml.parse(xmlString));
	}

	inline public static function simpleRefValue(typeName:String, value:String):ArpSeed {
		return new ArpSeed(typeName, null, null, value, ArpHeat.Cold, null, value, null);
	}

	inline public static function simpleValue(typeName:String, value:String):ArpSeed {
		return new ArpSeed(typeName, null, null, null, ArpHeat.Cold, null, value, null);
	}

	public static function fromXml(xml:Xml):ArpSeed {
		switch (xml.nodeType) {
			case XmlType.Document: xml = xml.firstElement();
			case XmlType.Element:
			case _: return simpleRefValue(xml.nodeName, xml.nodeValue);
		}

		var typeName:String = xml.nodeName;
		var template:String = null;
		var name:String = null;
		var ref:String = null;
		var heat:ArpHeat = ArpHeat.Cold;
		var key:String = null;
		var value:String = null;
		var children:Array<ArpSeed> = null;

		for (attrName in xml.attributes()) {
			var attr:String = xml.get(attrName);
			switch (attrName) {
				case "type":
					typeName = attr;
				case "class", "template":
					template = attr;
				case "name":
					name = attr;
				case "ref":
					ref = attr;
				case "heat":
					heat = ArpHeat.fromName(attr);
				case "key":
					key = attr;
				case "value":
					value = attr;
				case _:
					// NOTE leaf seeds by xml attr are also treated as ref; text nodes are not
					if (children == null) children = []; children.push(simpleRefValue(attrName, attr));
			}
		}
		for (node in xml) {
			switch (node.nodeType) {
				case XmlType.Element: if (children == null) children = []; children.push(ArpSeed.fromXml(node));
				case XmlType.PCData, XmlType.CData: if (value == null) value = ""; value += node.nodeValue;
				case _: // ignore
			}
		}
		return new ArpSeed(typeName, template, name, ref, heat, key, value, children);
	}
}
