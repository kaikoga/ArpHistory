package net.kaikoga.arp.seed;

import haxe.io.Bytes;
import Xml.XmlType;

class ArpXmlSeedReader {

	inline public function new() {
	}

	inline public function parseXmlBytes(bytes:Bytes):ArpSeed {
		return parseXmlString(bytes.toString());
	}

	inline public function parseXmlString(xmlString:String):ArpSeed {
		return parse(Xml.parse(xmlString));
	}

	inline public function parse(xml:Xml):ArpSeed {
		return parseInternal(xml, ArpSeedEnv.empty());
	}

	private function parseInternal(xml:Xml, env:ArpSeedEnv):ArpSeed {
		switch (xml.nodeType) {
			case XmlType.Document: xml = xml.firstElement();
			case XmlType.Element:
			case _: return ArpSeed.simpleRefValue(xml.nodeName, xml.nodeValue, env);
		}

		var typeName:String = xml.nodeName;
		var template:String = null;
		var name:String = null;
		var ref:String = null;
		var heat:String = null;
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
					heat = attr;
				case "key":
					key = attr;
				case "value":
					value = attr;
				case _:
					// NOTE leaf seeds by xml attr are also treated as ref; text nodes are not
					if (children == null) children = [];
					children.push(ArpSeed.simpleRefValue(attrName, attr, env));
			}
		}

		for (node in xml) {
			switch (node.nodeType) {
				case XmlType.Element:
					if (node.nodeName == "env") {
						env.add(node.get("name"), node.get("value"));
					} else {
						if (children == null) children = [];
						children.push(parseInternal(node, env));
					}
				case XmlType.PCData, XmlType.CData:
					if (value == null) value = "";
					value += node.nodeValue;
				case _: // ignore
			}
		}
		return new ArpSeed(typeName, template, name, ref, heat, key, value, env, children);
	}
}
