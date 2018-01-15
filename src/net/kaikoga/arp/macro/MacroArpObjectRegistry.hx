package net.kaikoga.arp.macro;

#if macro

import haxe.macro.ComplexTypeTools;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.TypeTools;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.reflect.ArpClassInfo;
import net.kaikoga.arp.domain.reflect.ArpDomainInfo;
import net.kaikoga.arp.domain.reflect.ArpFieldKind;
import net.kaikoga.arp.writers.help.ArpHelpWriter;

class MacroArpObjectRegistry {

	private var domainInfo:ArpDomainInfo;
	private var templateInfos:Map<String, ArpClassInfo>;
	private var macroArpObjects:Map<String, MacroArpObject>;

	private function new() {
		this.onMacroContextReused();
	}

	private function registerPrimitive(fieldKind:ArpFieldKind, name:String, fqn:String = null):Void {
		if (fqn == null) fqn = name;
		templateInfos.set(fqn, ArpClassInfo.primitive(fieldKind, new ArpType(name), fqn));
	}

	public static function registerStructInfo(name:String, fqn:String):Void {
		instance.templateInfos.set(fqn, ArpClassInfo.struct(new ArpType(name), fqn));
	}

	public static function registerTemplateInfo(fqn:String, macroArpObject:MacroArpObject):Void {
		instance.macroArpObjects.set(fqn, macroArpObject);
		instance.templateInfos.set(fqn, macroArpObject.templateInfo);
		instance.domainInfo.classInfos.push(macroArpObject.templateInfo);
	}

	private static function toFqn(complexType:ComplexType):String {
		return MacroArpUtil.getFqnOfType(ComplexTypeTools.toType(complexType));
	}

	public static function getTemplateInfo(fqn:String):ArpClassInfo {
		return instance.templateInfos.get(fqn);
	}

	public static function templateInfoOfNativeType(nativeType:ComplexType):ArpClassInfo {
		return instance.templateInfos.get(toFqn(nativeType));
	}

	public static function arpTypeOf(nativeType:ComplexType):ArpType {
		return templateInfoOfNativeType(nativeType).arpType;
	}

	public static function getMacroArpObject(fqn:String):MacroArpObject {
		return instance.macroArpObjects.get(fqn);
	}

	public static function getLocalMacroArpObject():MacroArpObject {
		return getMacroArpObject(MacroArpUtil.getFqnOfType(Context.getLocalType()));
	}

	public static function toAutoAddTemplates(arpDomain:Expr):Expr {
		var block:Array<Expr> = [];
		for (macroArpObject in instance.macroArpObjects) {
			var klassName:String = macroArpObject.templateInfo.fqn;
			var klass:Expr = Context.parse(klassName, macroArpObject.classDef.nativePos);
			block.push(macro ${ arpDomain } .addTemplate(${ klass }));
			// block.push(macro this.addTemplate(Type.resolveClass($v{klass})));
		}
		return macro @mergeBlock $b{ block };
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
		domainInfo = new ArpDomainInfo();
		macroArpObjects = new Map();
		templateInfos = new Map();

		registerPrimitive(ArpFieldKind.PrimInt, "StdTypes.Int");
		registerPrimitive(ArpFieldKind.PrimFloat, "StdTypes.Float");
		registerPrimitive(ArpFieldKind.PrimBool, "StdTypes.Bool");
		registerPrimitive(ArpFieldKind.PrimString, "String");
		return true;
	}

	private static var _instance:MacroArpObjectRegistry;
	private static var instance(get, never):MacroArpObjectRegistry;
	private static function get_instance():MacroArpObjectRegistry {
		if (_instance == null) {
			_instance = new MacroArpObjectRegistry();
			// Context.onMacroContextReused(_instance.onMacroContextReused);
#if arp_doc
			Context.onAfterGenerate(_instance.onAfterGenerate);
#end
		}
		return _instance;
	}
}

#end
