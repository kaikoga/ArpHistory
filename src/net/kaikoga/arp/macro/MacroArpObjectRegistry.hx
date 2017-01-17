package net.kaikoga.arp.macro;

#if macro

import net.kaikoga.arp.domain.reflect.ArpFieldKind;
import net.kaikoga.arp.writers.help.ArpHelpWriter;
import haxe.macro.Context;
import net.kaikoga.arp.domain.reflect.ArpDomainInfo;
import haxe.macro.ComplexTypeTools;
import haxe.macro.TypeTools;
import haxe.macro.Expr.ComplexType;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.reflect.ArpClassInfo;

class MacroArpObjectRegistry {

	private var domainInfo:ArpDomainInfo;
	private var templateInfos:Map<String, ArpClassInfo>;

	private function new() {
		templateInfos = new Map();

		registerPrimitive(ArpFieldKind.PrimInt, "Int");
		registerPrimitive(ArpFieldKind.PrimFloat, "Float");
		registerPrimitive(ArpFieldKind.PrimBool, "Bool");
		registerPrimitive(ArpFieldKind.PrimString, "String");

		domainInfo = new ArpDomainInfo();

		Context.onMacroContextReused(function() return onMacroContextReused());
		#if arp_doc
		Context.onAfterGenerate(function() onAfterGenerate());
		#end
	}

	private function registerPrimitive(fieldKind:ArpFieldKind, name:String, fqn:String = null):Void {
		if (fqn == null) fqn = name;
		templateInfos.set(fqn, ArpClassInfo.primitive(fieldKind, new ArpType(name), fqn));
	}

	public static function registerStructInfo(name:String, fqn:String):Void {
		instance.templateInfos.set(fqn, ArpClassInfo.struct(new ArpType(name), fqn));
	}

	public static function registerTemplateInfo(fqn:String, templateInfo:ArpClassInfo):Void {
		instance.templateInfos.set(fqn, templateInfo);
		instance.domainInfo.classInfos.push(templateInfo);
	}

	private static function toFqn(complexType:ComplexType):String {
		return TypeTools.toString(ComplexTypeTools.toType(complexType));
	}

	public static function templateInfoOf(nativeType:ComplexType):ArpClassInfo {
		return instance.templateInfos.get(toFqn(nativeType));
	}

	public static function arpTypeOf(nativeType:ComplexType):ArpType {
		return templateInfoOf(nativeType).arpType;
	}

	private function onAfterGenerate():Void {
		var writer:ArpHelpWriter = new ArpHelpWriter();
		var prefix:String = Context.definedValue("arp_doc");
		if (prefix == "1") prefix = "doc/";
		if (prefix.indexOf("/") < 0) prefix = prefix + "/";
		writer.write(domainInfo, prefix);
	}

	private function onMacroContextReused():Bool {
		// discard registered types
		domainInfo = null;
		templateInfos = null;
		return true;
	}

	private static var _instance:MacroArpObjectRegistry;
	private static var instance(get, never):MacroArpObjectRegistry;
	private static function get_instance():MacroArpObjectRegistry {
		if (_instance == null) _instance = new MacroArpObjectRegistry();
		return _instance;
	}
}

#end
