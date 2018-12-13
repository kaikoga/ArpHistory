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
		result += '<h1>ArpDomain Reference</h1>\n';
		result += '<hr />\n';
		result += '<h2>${classInfo.arpType}:${classInfo.className}</h2>\n';
		result += '<p>${classInfo.fqn}</p>\n';
		result += '<p>${classInfo.doc}</p>\n';
		result += '<div><pre>\n${this.printXml()}\n</pre></div>\n\n';
		result += '<h2>Fields</h2>\n';
		result += '${this.printDocs()}\n\n';
		return result;
	}

	private function printXml():String {
		var result:String = "";
		result += '<${classInfo.arpType} name="name" class="${classInfo.className}"';
		for (field in classInfo.fields) {
			var placeholder:String = getPlaceholder(field);
			if (field.groupName != null) {
				result += populateAttribute(field.groupName, field, placeholder);
			}
			if (field.elementName != null) {
				result += populateAttribute(field.elementName, field, placeholder);
			}
		}
		result += '/>\n';
		for (field in classInfo.fields) {
			var placeholder:String = getPlaceholder(field);
			if (field.groupName != null) {
				result += populateElement(true, field.groupName, field, placeholder);
			}
			if (field.elementName != null) {
				result += populateElement(false, field.elementName, field, placeholder);
			}
		}
		for (field in classInfo.fields) {
			var placeholder:String = getPlaceholder(field);
			result += populateTextNode(field, placeholder);
		}
		result += '</${classInfo.arpType}>\n';

		return StringTools.htmlEscape(result);
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

	private function populateAttribute(name:String, field:ArpFieldInfo, placeholder:String):String {
		if (field.isCollection) return "";
		return '$name = "$placeholder"';
	}

	private function populateElement(mayGroup:Bool, name:String, field:ArpFieldInfo, placeholder:String):String {
		var willGroup = mayGroup && field.isCollection;
		if (willGroup) name = field.arpType;

		var key:String = "";
		switch (field.fieldDs) {
			case ArpFieldDs.Scalar:
			case ArpFieldDs.StdArray, ArpFieldDs.StdList, ArpFieldDs.DsISet, ArpFieldDs.DsIList:
			case ArpFieldDs.StdMap, ArpFieldDs.DsIMap, ArpFieldDs.DsIOmap:
				key = 'key="key" ';
			default:
		}

		var value:String = switch (field.fieldKind) {
			case ArpFieldKind.PrimBool, ArpFieldKind.PrimInt, ArpFieldKind.PrimFloat, ArpFieldKind.PrimString:
				'value="${placeholder}" ';
			case ArpFieldKind.StructKind:
				switch (field.arpType.toString()) {
					case "Range":
						'min="minValue" max="maxValue" ';
					case "Color":
						'value="#000000@00 $placeholder" ';
					case "Position":
						'x="x" y="y" z="z" dir="dir" ';
					case "HitArea":
						'left="0" right="1" top="0" bottom="1" hind="0" fore="1" ';
					case "Params":
						'value="params $placeholder" ';
					case some:
						'value="$placeholder" ';
				}
			case ArpFieldKind.ReferenceKind:
				'ref="$placeholder" ';
		}

		var result:String = '<$name $key$value/>';

		if (willGroup) return '<${field.groupName}>\n\t$result\n</${field.groupName}>\n';
		return result + "\n";
	}

	private function populateTextNode(field:ArpFieldInfo, placeholder:String):String {
		if (field.groupName != "value") return "";
		return '\tplaceholder\n';
	}

	private function printDocs():String {
		var result:String = "";
		result += '<section>\n';
		for (field in classInfo.fields) {
			result += '<h3>${field.nativeName}</h3>\n';
			result += '<section>${field.doc}</section>\n';
			result += '<hr />\n';
		}
		result += '</section>\n';
		return result;
	}

}
