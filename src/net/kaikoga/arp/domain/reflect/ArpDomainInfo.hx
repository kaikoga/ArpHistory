package net.kaikoga.arp.domain.reflect;

import net.kaikoga.arp.domain.core.ArpType;
class ArpDomainInfo {

	public var templates(default, null):Array<ArpTemplateInfo>;

	public function new() {
		this.templates = [];
	}

	// FIXME @:followAbstracts
	public function groupByArpType():Map<String, Array<ArpTemplateInfo>> {
		var result:Map<String, Array<ArpTemplateInfo>> = new Map();
		for (template in this.templates) {
			var arpType:String = template.arpType; 
			if (result.exists(arpType)) {
				result.get(arpType).push(template);
			} else {
				result.set(arpType, [template]);
			}
		}
		return result;
	}
}
