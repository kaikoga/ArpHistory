package net.kaikoga.arp.domain.seed;

import Xml.XmlType;
class ArpSeed {

	private var _name:String;
	private var _template:String;
	private var _value:Dynamic;
	private var _children:Array<ArpSeed>;

	inline public function new(name:String, template:String, value:Dynamic, children:Array<ArpSeed>) {
		this._name = name;
		this._template = template;
		this._value = value;
		this._children = children;
	}

	inline public function name():String return this._name;
	inline public function template():String return this._template;
	inline public function value():Dynamic return this._value;
	inline public function children():Array<ArpSeed> return this._children;

	inline public function iterator():Iterator<ArpSeed> return (this._children != null) ? this._children.iterator() : [].iterator();

	public static function fromXml(xml:Xml):ArpSeed {
		switch (xml.nodeType) {
			case XmlType.Document: xml = xml.firstElement();
			case XmlType.Element:
			case _: return new ArpSeed(xml.nodeName, null, xml.nodeValue, null);
		}
		
		var name:String = xml.nodeName;
		var template:String = null;
		var value:String = "";
		var children:Array<ArpSeed> = [];
		
		for (attrName in xml.attributes()) {
			switch (attrName) {
				case "name":
				case "class", "template":
					template = xml.get(attrName);
				case _:
					children.push(new ArpSeed(attrName, null, xml.get(attrName), null));
			} 
		}
		for (node in xml) {
			switch (node.nodeType) {
				case XmlType.Element: children.push(ArpSeed.fromXml(node));
				case XmlType.PCData, XmlType.CData: value += node.nodeValue;
				case _: // ignore
			}
		}
		return new ArpSeed(name, template, value, children);
	}
}
