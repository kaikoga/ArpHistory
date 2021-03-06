package arp.macro;

#if macro

import haxe.macro.ComplexTypeTools;
import haxe.macro.Context;
import haxe.macro.Expr;
import arp.domain.core.ArpType;
import arp.domain.reflect.ArpClassInfo;
import arp.domain.reflect.ArpDomainInfo;
import arp.domain.reflect.ArpFieldKind;
import arp.writers.help.ArpHelpWriter;

class MacroArpObjectRegistry {

	private var domainInfo:ArpDomainInfo;
	private var templateInfos:Map<String, ArpClassInfo>;
	private var macroArpObjects:Map<String, MacroArpObject>;

	private function new() {
		this.onMacroContextReused();
	}

	private function registerPrimitive(fieldKind:ArpFieldKind, name:String, fqn:String = null, doc:String = null):Void {
		if (fqn == null) fqn = name;
		templateInfos.set(fqn, ArpClassInfo.primitive(fieldKind, new ArpType(name), fqn, doc));
	}

	public static function registerStructInfo(name:String, fqn:String, doc:String, stringPlaceholder:String, seedPlaceholder:String):Void {
		var structInfo:ArpClassInfo = ArpClassInfo.struct(new ArpType(name), fqn, doc, stringPlaceholder, seedPlaceholder);
		instance.templateInfos.set(fqn, structInfo);
		instance.domainInfo.structInfos.push(structInfo);
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
		function linkDerivedClasses():Void {
			for (macroArpObject in this.macroArpObjects) macroArpObject.populateBaseFields();
		}

		function writeDocs():Void {
			var prefix:String = Context.definedValue("arp_doc");
			if (prefix == "1") prefix = "doc/";
			if (prefix.indexOf("/") < 0) prefix = prefix + "/";
			new ArpHelpWriter(domainInfo, prefix).write();
		}

		linkDerivedClasses();
		writeDocs();
	}

	private function onMacroContextReused():Bool {
		// discard registered types
		domainInfo = new ArpDomainInfo();
		macroArpObjects = new Map();
		templateInfos = new Map();

		registerPrimitive(ArpFieldKind.PrimInt, "Int", "StdTypes.Int", "Primitive integer.");
		registerPrimitive(ArpFieldKind.PrimFloat, "Float", "StdTypes.Float", "Primitive float.");
		registerPrimitive(ArpFieldKind.PrimBool, "Bool", "StdTypes.Bool", "Primitive boolean.");
		registerPrimitive(ArpFieldKind.PrimString, "String", "String", "Primitive string.");
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
