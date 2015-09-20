package net.kaikoga.arp.domain.seed;

import Xml.XmlType;

class ArpSeed {

	private var _typeName:String;
	private var _name:String;
	private var _ref:String;
	private var _template:String;
	private var _value:Dynamic;
	private var _children:Array<ArpSeed>;

	inline public function new(typeName:String, template:String, name:String, ref:String, value:Dynamic, children:Array<ArpSeed>) {
		this._typeName = typeName;
		this._template = template;
		this._name = name;
		this._ref = ref;
		this._value = value;
		this._children = children;
	}

	inline public function typeName():String return this._typeName;
	inline public function template():String return this._template;
	inline public function name():String return this._name;
	inline public function ref():String return this._ref;
	inline public function value():Dynamic return this._value;
	inline public function children():Array<ArpSeed> return this._children;

	inline public function hasChildren():Bool return this._children != null;
	inline public function iterator():Iterator<ArpSeed> return this.hasChildren() ? this._children.iterator() : [].iterator();


	inline public static function fromXmlString(xmlString:String):ArpSeed {
		return fromXml(Xml.parse(xmlString));
	}

	public static function fromXml(xml:Xml):ArpSeed {
		switch (xml.nodeType) {
			case XmlType.Document: xml = xml.firstElement();
			case XmlType.Element:
			case _: return new ArpSeed(xml.nodeName, null, null, xml.nodeValue, xml.nodeValue, null);
		}

		var typeName:String = xml.nodeName;
		var template:String = null;
		var name:String = null;
		var ref:String = null;
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
				case "value":
					value = attr;
				case _:
					// NOTE leef seeds by xml attr are also treated as ref; text nodes are not
					if (children == null) children = []; children.push(new ArpSeed(attrName, null, null, attr, attr, null));
			}
		}
		for (node in xml) {
			switch (node.nodeType) {
				case XmlType.Element: if (children == null) children = []; children.push(ArpSeed.fromXml(node));
				case XmlType.PCData, XmlType.CData: if (value == null) value = ""; value += node.nodeValue;
				case _: // ignore
			}
		}
		return new ArpSeed(typeName, template, name, ref, value, children);
	}
}
