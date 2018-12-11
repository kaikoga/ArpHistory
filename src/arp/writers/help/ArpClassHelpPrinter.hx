package arp.writers.help;

import arp.domain.reflect.ArpClassInfo;
import arp.domain.reflect.ArpFieldDs;
import arp.domain.reflect.ArpFieldInfo;
import arp.domain.reflect.ArpFieldKind;

class ArpClassHelpPrinter {

	private var classInfo:ArpClassInfo;

	public function new(classInfo:ArpClassInfo) {
		this.classInfo = classInfo;
	}

	public function print():String {
		var result:String = "";
		result += '<h1>ArpDomain Reference</h1>';
		result += '<hr />';
		result += '<h2>${classInfo.arpType}:${classInfo.className}</h2>\n';
		result += '<p>${classInfo.fqn}</p>\n';
		result += '<p>${classInfo.doc}</p>\n';
		result += '<div><pre>${this.printXml()}</pre></div>\n\n';
		result += '<h2>Fields</h2>\n';
		result += '${this.printDocs()}\n\n';
		return result;
	}

	private function printXml():String {
		var xml:Xml = Xml.parse('<${classInfo.arpType} name="name" class="${classInfo.className}" />').firstElement();
		xml.addChild(Xml.parse('<tag value="tagName=tagValue" />').firstElement());
		this.addFields(xml);
		return StringTools.htmlEscape(haxe.xml.Printer.print(xml, true));
	}

	private function addFields(xml:Xml):Void {
		for (field in classInfo.fields) {
			var placeholder:String = getPlaceholder(field);
			if (field.groupName != null) {
				populateAttribute(xml, field.groupName, field, placeholder);
				populateElement(xml, true, field.groupName, field, placeholder);
			}
			if (field.elementName != null) {
				populateAttribute(xml, field.elementName, field, placeholder);
				populateElement(xml, false, field.elementName, field, placeholder);
			}
		}
		for (field in classInfo.fields) {
			var placeholder:String = getPlaceholder(field);
			populateTextNode(xml, field, placeholder);
		}
	}

	private function getPlaceholder(field:ArpFieldInfo):String {
		var placeholder:String = field.arpType.toString() + " " + field.nativeName;
		/*
		if (field.defaultValue) {
			placeholder += "=" + field.defaultValue;
		}
		*/
		return placeholder;
	}

	private function populateAttribute(xml:Xml, name:String, field:ArpFieldInfo, placeholder:String) {
		if (!field.isCollection) xml.set('${name}', placeholder);
	}

	private function populateElement(xml:Xml, mayGroup:Bool, name:String, field:ArpFieldInfo, placeholder:String) {
		if (mayGroup && field.isCollection) {
			var group:Xml = Xml.createElement(field.groupName);
			xml.addChild(group);
			xml = group;
			name = field.arpType;
		}

		var node:Xml;
		switch (field.fieldKind) {
			case ArpFieldKind.PrimBool, ArpFieldKind.PrimInt, ArpFieldKind.PrimFloat, ArpFieldKind.PrimString:
				node = Xml.parse('<${name} value="${placeholder}" />').firstElement();
			case ArpFieldKind.StructKind:
				switch (field.arpType.toString()) {
					case "Range":
						node = Xml.parse('<${name} min="minValue" max="maxValue" />').firstElement();
					case "Color":
						node = Xml.parse('<${name} value="${placeholder}" />').firstElement();
					case "Position":
						node = Xml.parse('<${name} x="x" y="y" z="z" dir="dir" />').firstElement();
					case "HitArea":
						node = Xml.parse('<${name} left="0" right="1" top="0" bottom="1" hind="0" fore="1" />').firstElement();
					case "Params":
						node = Xml.parse('<${name} value="${placeholder}" />').firstElement();
					case some:
						node = Xml.parse('<${name} ${some}="${placeholder}">${placeholder}</${name}>').firstElement();
				}
			case ArpFieldKind.ReferenceKind:
				node = Xml.parse('<${name} ref="${placeholder}" />').firstElement();
		}

		switch (field.fieldDs) {
			case ArpFieldDs.Scalar:
			case ArpFieldDs.StdArray, ArpFieldDs.StdList, ArpFieldDs.DsISet, ArpFieldDs.DsIList:
			case ArpFieldDs.StdMap, ArpFieldDs.DsIMap, ArpFieldDs.DsIOmap:
				node.set("key", "key");
			default:
		}

		xml.addChild(node);
	}

	private function populateTextNode(parent:Xml, field:ArpFieldInfo, placeholder:String) {
		if (field.groupName == "value") parent.addChild(Xml.createPCData(placeholder));
	}

	private function printDocs():String {
		var xml:Xml = Xml.createElement('section');
		for (field in classInfo.fields) {
			xml.addChild(Xml.parse('<h3>${field.nativeName}</h3>').firstElement());
			xml.addChild(Xml.parse('<section>${field.doc}</section>').firstElement());
			xml.addChild(Xml.createElement('hr'));
		}
		return haxe.xml.Printer.print(xml, true);
	}

}
