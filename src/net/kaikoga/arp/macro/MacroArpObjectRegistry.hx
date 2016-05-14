package net.kaikoga.arp.macro;

#if macro

import net.kaikoga.arp.domain.core.ArpType;
import haxe.macro.Expr;
import haxe.macro.Context;
import net.kaikoga.arp.domain.reflect.ArpTemplateInfo;

class MacroArpObjectRegistry {

	private static var templateInfos:Map<String, ArpTemplateInfo>;

	public static function registerTemplateInfo(fqn:String, templateInfo:ArpTemplateInfo):Void {
		if (templateInfos == null) {
			templateInfos = new Map();
			// in case of reuse, nvm
		}
		Context.warning(fqn + ":" + templateInfo.arpType + "/" + templateInfo.templateName, Context.currentPos());
		for (fieldInfo in templateInfo.fields) {
			Context.warning(Std.string(fieldInfo), Context.currentPos());
		}
		templateInfos.set(fqn, templateInfo);
	}

	public static function arpTypeOf(fqn:String):ArpType {
		var templateInfo:ArpTemplateInfo = templateInfos.get(fqn);
		if (templateInfo == null) throw "nullnullnull" + fqn;
		return templateInfo.arpType;
	}
}

#end
