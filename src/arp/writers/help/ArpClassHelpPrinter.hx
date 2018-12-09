package arp.writers.help;

import arp.domain.reflect.ArpClassInfo;
import arp.domain.reflect.ArpFieldDs;
import arp.domain.reflect.ArpFieldInfo;
import arp.domain.reflect.ArpFieldKind;

class ArpClassHelpPrinter {

	private var classInfo:ArpClassInfo;

	public function new() {
	}

	public function print(classInfo:ArpClassInfo):String {
		this.classInfo = classInfo;

		var result:String = "";
		result += '<h2>${classInfo.arpType}:${classInfo.className}</h2>\n';
		result += '<p>${classInfo.fqn}</p>\n';
		result += '<div><pre>${this.printXml()}</pre></div>\n\n';
		return result;
	}

	private function printXml():String {
		var xml:Xml = Xml.parse('<${classInfo.arpType} name="name" class="${classInfo.className}" />').firstElement();
		xml.addChild(Xml.parse('<tag value="tagName=tagValue" />').firstElement());
		for (field in classInfo.fields) this.addField(xml, field);
		return StringTools.htmlEscape(haxe.xml.Printer.print(xml, true));
	}

	private function addField(xml:Xml, field:ArpFieldInfo):Void {
		var placeholder:String = field.nativeName;
		/*
		if (field.defaultValue) {
			placeholder += "=" + field.defaultValue;
		}
		*/
		var node:Xml;

		switch (field.fieldKind) {
			case ArpFieldKind.PrimBool, ArpFieldKind.PrimInt, ArpFieldKind.PrimFloat, ArpFieldKind.PrimString:
				node = Xml.parse('<${field.groupName}>${placeholder}</${field.groupName}>').firstElement();
			case ArpFieldKind.StructKind:
				switch (field.arpType.toString()) {
					case "Range":
						node = Xml.parse('<${field.groupName} min="minValue" max="maxValue" />').firstElement();
					case "Color":
						node = Xml.parse('<${field.groupName}>${placeholder}</${field.groupName}>').firstElement();
					case "Position":
						node = Xml.parse('<${field.groupName} x="x" y="y" z="z" dir="dir" />').firstElement();
					case "HitArea":
						node = Xml.parse('<${field.groupName} left="0" right="1" top="0" bottom="1" hind="0" fore="1" />').firstElement();
					case "Params":
						node = Xml.parse('<${field.groupName}>${placeholder}</${field.groupName}>').firstElement();
					case some:
						node = Xml.parse('<${field.groupName} ${some}="${placeholder}">${placeholder}</${field.groupName}>').firstElement();
				}
			case ArpFieldKind.ReferenceKind:
				node = Xml.parse('<${field.groupName} ref="${placeholder}" />').firstElement();
		}

		switch (field.fieldDs) {
			case ArpFieldDs.Scalar:
				xml.set('${field.groupName}', placeholder);
			case ArpFieldDs.StdArray, ArpFieldDs.StdList, ArpFieldDs.DsISet, ArpFieldDs.DsIList:
			case ArpFieldDs.StdMap, ArpFieldDs.DsIMap, ArpFieldDs.DsIOmap:
				node.set("key", "key");
			default:
		}

		xml.addChild(node);
		if (field.groupName == "value") xml.addChild(Xml.createPCData(placeholder));
	}

}
