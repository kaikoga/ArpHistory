package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Context;
import net.kaikoga.arp.domain.reflect.ArpTemplateInfo;

class MacroArpObjectRegistry {

	private static var templateInfos:Array<ArpTemplateInfo>;

	public static function registerTemplateInfo(templateInfo:ArpTemplateInfo):Void {
		if (templateInfos == null) {
			templateInfos = [];
		}
		Context.warning(templateInfo.arpType + "/" + templateInfo.templateName, Context.currentPos());
		for (fieldInfo in templateInfo.fields) {
			Context.warning(Std.string(fieldInfo), Context.currentPos());
		}
		templateInfos.push(templateInfo);
	}
}

#end
