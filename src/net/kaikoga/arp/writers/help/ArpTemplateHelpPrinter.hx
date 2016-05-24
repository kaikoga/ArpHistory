package net.kaikoga.arp.writers.help;

import net.kaikoga.arp.domain.reflect.ArpFieldDs;
import net.kaikoga.arp.domain.reflect.ArpFieldType;
import net.kaikoga.arp.domain.reflect.ArpFieldInfo;
import net.kaikoga.arp.domain.reflect.ArpTemplateInfo;

class ArpTemplateHelpPrinter {

	private var template:ArpTemplateInfo;

	public function new() {
	}

	public function print(template:ArpTemplateInfo):String {
		this.template = template;

		var result:String = "";
		result += '<h2>${template.arpType}:${template.templateName}</h2>\n';
		result += '<p>${template.fqn}</p>\n';
		result += '<div><pre>${this.printXml()}</pre></div>\n\n';
		return result;
	}

	private function printXml():String {
		var xml:Xml = Xml.parse('<${template.arpType} name="name" class="${template.templateName}" />').firstElement();
		xml.addChild(Xml.parse('<tag value="tagName=tagValue" />').firstElement());
		for (field in template.fields) this.addField(xml, field);
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

		switch (field.fieldType) {
			case ArpFieldType.PrimBool(_), ArpFieldType.PrimInt(_), ArpFieldType.PrimFloat(_), ArpFieldType.PrimString(_):
				node = Xml.parse('<${field.name}>${placeholder}</${field.name}>').firstElement();
			case ArpFieldType.StructType(arpType):
				switch (arpType.toString()) {
					case "Range":
						node = Xml.parse('<${field.name} min="minValue" max="maxValue" />').firstElement();
					case "Color":
						node = Xml.parse('<${field.name}>${placeholder}</${field.name}>').firstElement();
					case "Position":
						node = Xml.parse('<${field.name} x="x" y="y" z="z" dir="dir" />').firstElement();
					case "HitArea":
						node = Xml.parse('<${field.name} left="0" right="1" top="0" bottom="1" hind="0" fore="1" />').firstElement();
					case "Params":
						node = Xml.parse('<${field.name}>${placeholder}</${field.name}>').firstElement();
					case some:
						node = Xml.parse('<${field.name} ${some}="${placeholder}">${placeholder}</${field.name}>').firstElement();
				}
			case ArpFieldType.ReferenceType(arpType):
				node = Xml.parse('<${field.name} ref="${placeholder}" />').firstElement();
		}

		switch (field.fieldDs) {
			case ArpFieldDs.Scalar:
				xml.set('${field.name}', placeholder);
			case ArpFieldDs.StdArray, ArpFieldDs.StdList, ArpFieldDs.DsISet, ArpFieldDs.DsIList:
			case ArpFieldDs.StdMap, ArpFieldDs.DsIMap, ArpFieldDs.DsIOmap:
				node.set("key", "key");
			default:
		}

		xml.addChild(node);
		if (field.name == "value") xml.addChild(Xml.createPCData(placeholder));
	}

}
