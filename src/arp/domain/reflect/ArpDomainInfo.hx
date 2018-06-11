package arp.domain.reflect;

class ArpDomainInfo {

	public var classInfos(default, null):Array<ArpClassInfo>;

	public function new() {
		this.classInfos = [];
	}

	// FIXME @:followAbstracts
	public function groupByArpType():Map<String, Array<ArpClassInfo>> {
		var result:Map<String, Array<ArpClassInfo>> = new Map();
		for (classInfo in this.classInfos) {
			var arpType:String = classInfo.arpType;
			if (result.exists(arpType)) {
				result.get(arpType).push(classInfo);
			} else {
				result.set(arpType, [classInfo]);
			}
		}
		return result;
	}
}
