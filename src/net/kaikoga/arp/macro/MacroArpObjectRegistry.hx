package net.kaikoga.arp.macro;

#if macro

import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.reflect.ArpTemplateInfo;

class MacroArpObjectRegistry {

	private static var templateInfos:Map<String, ArpTemplateInfo>;

	public static function registerTemplateInfo(fqn:String, templateInfo:ArpTemplateInfo):Void {
		if (templateInfos == null) {
			templateInfos = new Map();
			// in case of reuse, nvm
		}
		templateInfos.set(fqn, templateInfo);
	}

	public static function arpTypeOf(fqn:String):ArpType {
		var templateInfo:ArpTemplateInfo = templateInfos.get(fqn);
		if (templateInfo == null) throw "ArpType not registered for " + fqn;
		return templateInfo.arpType;
	}
}

#end
