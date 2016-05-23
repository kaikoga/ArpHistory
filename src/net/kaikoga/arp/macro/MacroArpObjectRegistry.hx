package net.kaikoga.arp.macro;

#if macro

import net.kaikoga.arp.writers.help.ArpHelpWriter;
import haxe.macro.Context;
import net.kaikoga.arp.domain.reflect.ArpDomainInfo;
import haxe.macro.ComplexTypeTools;
import haxe.macro.TypeTools;
import haxe.macro.Expr.ComplexType;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.reflect.ArpTemplateInfo;

class MacroArpObjectRegistry {

	private static var domainInfo:ArpDomainInfo;
	private static var templateInfos:Map<String, ArpTemplateInfo>;

	private static function registerBuiltin(name:String, fqn:String = null):Void {
		if (fqn == null) fqn = name;
		templateInfos.set(fqn, new ArpTemplateInfo(new ArpType(name), name, null));
	}

	public static function registerTemplateInfo(fqn:String, templateInfo:ArpTemplateInfo):Void {
		if (templateInfos == null) {
			templateInfos = new Map();

			// don't add these to ArpDomainInfo
			registerBuiltin("Int");
			registerBuiltin("Float");
			registerBuiltin("Bool");
			registerBuiltin("String");

			registerBuiltin("Area2d", "net.kaikoga.arp.structs.ArpArea2d");
			registerBuiltin("Color", "net.kaikoga.arp.structs.ArpColor");
			registerBuiltin("Direction", "net.kaikoga.arp.structs.ArpDirection");
			registerBuiltin("HitArea", "net.kaikoga.arp.structs.ArpHitArea");
			registerBuiltin("Params", "net.kaikoga.arp.structs.ArpParams");
			registerBuiltin("Position", "net.kaikoga.arp.structs.ArpPosition");
			registerBuiltin("Range", "net.kaikoga.arp.structs.ArpRange");
			domainInfo = new ArpDomainInfo();
			// in case of reuse, nvm
			#if arp_doc
			Context.onAfterGenerate(onAfterGenerate);
			#end
		}
		templateInfos.set(fqn, templateInfo);
		domainInfo.templates.push(templateInfo);
	}

	private static function arpTypeOfFqn(fqn:String):ArpType {
		var templateInfo:ArpTemplateInfo = templateInfos.get(fqn);
		if (templateInfo == null) throw "ArpType not registered for " + fqn;
		return templateInfo.arpType;
	}

	private static function toFqn(complexType:ComplexType):String {
		return TypeTools.toString(ComplexTypeTools.toType(complexType));
	}

	public static function arpTypeOf(nativeType:ComplexType):ArpType {
		return arpTypeOfFqn(toFqn(nativeType));
	}

	public static function onAfterGenerate():Void {
		var writer:ArpHelpWriter = new ArpHelpWriter();
		var prefix:String = Context.definedValue("arp_doc");
		if (prefix == "1") prefix = "doc/";
		if (prefix.indexOf("/") < 0) prefix = prefix + "/";
		writer.write(domainInfo, prefix);
	}
}

#end
