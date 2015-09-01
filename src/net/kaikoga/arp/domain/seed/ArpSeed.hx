package net.kaikoga.arp.domain.seed;

import Xml.XmlType;

class ArpSeed {

	private var _type:String;
	private var _name:String;
	private var _ref:String;
	private var _template:String;
	private var _value:Dynamic;
	private var _children:Array<ArpSeed>;

	inline public function new(type:String, template:String, name:String, ref:String, value:Dynamic, children:Array<ArpSeed>) {
		this._type = type;
		this._template = template;
		this._name = name;
		this._ref = ref;
		this._value = value;
		this._children = children;
	}

	inline public function type():String return this._type;
	inline public function template():String return this._template;
	inline public function name():String return this._name;
	inline public function ref():String return this._ref;
	inline public function value():Dynamic return this._value;
	inline public function children():Array<ArpSeed> return this._children;

	inline public function iterator():Iterator<ArpSeed> return (this._children != null) ? this._children.iterator() : [].iterator();

	public static function fromXml(xml:Xml):ArpSeed {
		switch (xml.nodeType) {
			case XmlType.Document: xml = xml.firstElement();
			case XmlType.Element:
			case _: return new ArpSeed(xml.nodeName, null, null, null, xml.nodeValue, null);
		}
		
		var type:String = xml.nodeName;
		var template:String = null;
		var name:String = null;
		var ref:String = null;
		var value:String = null;
		var children:Array<ArpSeed> = null;
		
		for (attrName in xml.attributes()) {
			switch (attrName) {
				case "type":
					type = xml.get(attrName);
				case "class", "template":
					template = xml.get(attrName);
				case "name":
					name = xml.get(attrName);
				case "ref":
					ref = xml.get(attrName);
				case _:
					if (children == null) children = []; children.push(new ArpSeed(attrName, null, null, null, xml.get(attrName), null));
			} 
		}
		for (node in xml) {
			switch (node.nodeType) {
				case XmlType.Element: if (children == null) children = []; children.push(ArpSeed.fromXml(node));
				case XmlType.PCData, XmlType.CData: if (value == null) value = ""; value += node.nodeValue;
				case _: // ignore
			}
		}
		return new ArpSeed(type, template, name, ref, value, children);
	}
}
