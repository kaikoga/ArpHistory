package net.kaikoga.arp.seed;

import net.kaikoga.arp.utils.ArpIdGenerator;
import haxe.io.Bytes;
import Xml.XmlType;

class ArpXmlSeedReader {

	inline public function new() {
	}

	inline public function parseXmlBytes(bytes:Bytes, env:ArpSeedEnv = null):ArpSeed {
		return parseXmlString(bytes.toString(), env);
	}

	inline public function parseXmlString(xmlString:String, env:ArpSeedEnv = null):ArpSeed {
		return parse(Xml.parse(xmlString), env);
	}

	inline public function parse(xml:Xml, env:ArpSeedEnv = null):ArpSeed {
		if (env == null) env = ArpSeedEnv.empty();
		return parseInternal(xml, ArpIdGenerator.first, env);
	}

	private function parseInternal(xml:Xml, uniqId:String, env:ArpSeedEnv):ArpSeed {
		switch (xml.nodeType) {
			case XmlType.Document: xml = xml.firstElement();
			case XmlType.Element:
			case _: return ArpSeed.simpleRefValue(xml.nodeName, uniqId, xml.nodeValue, env);
		}

		var idGen:ArpIdGenerator = new ArpIdGenerator();

		var typeName:String = xml.nodeName;
		var template:String = null;
		var name:String = null;
		var ref:String = null;
		var heat:String = null;
		var key:String = uniqId;
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
					children.push(ArpSeed.simpleRefValue(attrName, idGen.next(), attr, env));
			}
		}

		for (node in xml) {
			switch (node.nodeType) {
				case XmlType.Element:
					if (node.nodeName == "env") {
						env.add(node.get("name"), node.get("value"));
					} else {
						if (children == null) children = [];
						children.push(parseInternal(node, idGen.next(), env));
					}
				case XmlType.PCData, XmlType.CData:
					if (value == null) value = "";
					value += node.nodeValue;
				case _: // ignore
			}
		}
		return ArpSeed.complex(typeName, template, name, ref, heat, key, value, env, children);
	}
}
