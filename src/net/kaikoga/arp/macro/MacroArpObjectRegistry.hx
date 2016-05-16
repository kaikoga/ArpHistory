package net.kaikoga.arp.macro;

#if macro

import haxe.macro.ComplexTypeTools;
import haxe.macro.TypeTools;
import haxe.macro.Expr.ComplexType;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.reflect.ArpTemplateInfo;

class MacroArpObjectRegistry {

	private static var templateInfos:Map<String, ArpTemplateInfo>;

	private static function registerBuiltin(name:String, fqn:String = null):Void {
		if (fqn == null) fqn = name;
		templateInfos.set(fqn, new ArpTemplateInfo(new ArpType(name), name, null));
	}

	public static function registerTemplateInfo(fqn:String, templateInfo:ArpTemplateInfo):Void {
		if (templateInfos == null) {
			templateInfos = new Map();

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
			// in case of reuse, nvm
		}
		templateInfos.set(fqn, templateInfo);
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
}

#end
