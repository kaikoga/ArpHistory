package arp.writers.help;

import arp.domain.reflect.ArpClassInfo;
import arp.domain.reflect.ArpDomainInfo;
import arp.domain.reflect.ArpFieldDs;
import arp.domain.reflect.ArpFieldInfo;
import arp.domain.reflect.ArpFieldKind;
import arp.utils.StringBuffer;

class ArpClassHelpPrinter {

	private var domainInfo:ArpDomainInfo;
	private var classInfo:ArpClassInfo;

	public function new(domainInfo:ArpDomainInfo, classInfo:ArpClassInfo) {
		this.domainInfo = domainInfo;
		this.classInfo = classInfo;
	}

	public function print():String {
		var result:StringBuffer = 0;
		result >>= '
			<h1>ArpDomain Reference</h1>
			<hr />
			<h2>${classInfo.arpType}:${classInfo.className}</h2>
			<p>${classInfo.fqn}</p>
			<p>${classInfo.doc}</p>
			<div><pre>\n${this.printXml()}\n</pre></div>
			<h2>Fields</h2>
			${this.printDocs()}
		';
		return result;
	}

	private function printXml():String {
		var result:StringBuffer = 0;
		result += '<${classInfo.arpType} name="name" class="${classInfo.className}" ';
		for (field in classInfo.fields) {
			if (field.groupName != null) {
				result += populateAttribute(field.groupName, field);
			}
			if (field.elementName != null) {
				result += populateAttribute(field.elementName, field);
			}
		}
		result += '/>\n';
		for (field in classInfo.fields) {
			if (field.groupName != null) {
				result += populateElement(true, field.groupName, field);
			}
			if (field.elementName != null) {
				result += populateElement(false, field.elementName, field);
			}
		}
		for (field in classInfo.fields) {
			result += populateTextNode(field);
		}
		result += '</${classInfo.arpType}>';

		return StringTools.htmlEscape(result);
	}

	private function populateAttribute(name:String, field:ArpFieldInfo):String {
		if (field.isCollection) return "";
		switch (field.fieldKind) {
			case ArpFieldKind.PrimBool, ArpFieldKind.PrimInt, ArpFieldKind.PrimFloat, ArpFieldKind.PrimString:
				return '$name="${field.arpType}" ';
			case ArpFieldKind.StructKind:
				var structInfo:ArpClassInfo = this.domainInfo.findStructInfo(field.arpType);
				if (structInfo != null) {
					if (structInfo.stringPlaceholder != null) {
						return '$name="${structInfo.stringPlaceholder}" ';
					}
				}
				return '$name="${field.arpType}" ';
			case ArpFieldKind.ReferenceKind:
				return '$name="${field.arpType}" ';
		}
	}

	private function populateElement(mayGroup:Bool, name:String, field:ArpFieldInfo):String {
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

		var value:String;
		switch (field.fieldKind) {
			case ArpFieldKind.PrimBool, ArpFieldKind.PrimInt, ArpFieldKind.PrimFloat, ArpFieldKind.PrimString:
				value = 'value="${field.arpType}" ';
			case ArpFieldKind.StructKind:
				value = 'value="${field.arpType}" ';
				var structInfo:ArpClassInfo = this.domainInfo.findStructInfo(field.arpType);
				if (structInfo != null) {
					if (structInfo.seedPlaceholder != null) {
						value = "";
						for (k in Reflect.fields(structInfo.seedPlaceholder)) {
							value += '$k="${Reflect.field(structInfo.seedPlaceholder, k)}" ';
						}
					}
				}
			case ArpFieldKind.ReferenceKind:
				value = 'ref="${field.arpType}" ';
		}

		var result:String = '<$name $key$value/>';

		if (willGroup) return '<${field.groupName}>\n\t$result\n</${field.groupName}>\n';
		return result + "\n";
	}

	private function populateTextNode(field:ArpFieldInfo):String {
		if (field.groupName != "value") return "";
		return '\t${field.groupName}\n';
	}

	private function printDocs():String {
		var result:StringBuffer = 0;
		result <<= '<section>';
		for (field in classInfo.fields) {
			result >>= '
				<h3>${field.nativeName}</h3>
				<section>${field.doc}</section>
				<hr />
			';
		}
		result <<= '</section>';
		return result;
	}

}
