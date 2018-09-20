package arp.seed;

import arp.seed.impl.legacy.ArpSeedComplex;
import arp.seed.impl.legacy.ArpSeedSimpleObject;
import arp.seed.impl.legacy.ArpSeedSimpleAmbigiousValue;
import arp.seed.impl.legacy.ArpSeedSimpleLiteralValue;
import arp.seed.impl.legacy.ArpSeedSimpleReferenceValue;
import arp.utils.ArpIdGenerator;
import haxe.io.Bytes;
import Xml.XmlType;

class ArpXmlSeedReader {

	/*
		ArpXmlSeedReader spec:
		- Attributes:
		  - All keyword attributes are ignored
		  - All non-keyword attributes are ArpSeedSimpleAmbigiousValue
		- Elements:
		  - When an element has a "ref", it is an ArpSeedSimpleReferenceValue
		  - Else, an element is a Literal
			- ArpSeedSimpleObject if no child elements
			  - Text nodes inside will become virtual element
			- ArpSeedComplex if any child elements
			  - Text nodes inside will become ArpSeedSimpleLiteralValue
	 */

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
			case _: return new ArpSeedSimpleAmbigiousValue(xml.nodeName, uniqId, xml.nodeValue, env);
		}

		var idGen:ArpIdGenerator = new ArpIdGenerator();

		var typeName:String = xml.nodeName;
		var className:String = null;
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
				case "class":
					className = attr;
				case "name", "id":
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
					children.push(new ArpSeedSimpleAmbigiousValue(attrName, idGen.next(), attr, env));
			}
		}

		if (ref != null) return new ArpSeedSimpleReferenceValue(typeName, key, ref, env);

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

		if (children == null) {
			return new ArpSeedSimpleObject(typeName, className, name, heat, key, value, env);
		}
		if (value != null) children.push(new ArpSeedSimpleLiteralValue("value", idGen.next(), value, env));
		return new ArpSeedComplex(typeName, className, name, heat, key, children, env);
	}
}
