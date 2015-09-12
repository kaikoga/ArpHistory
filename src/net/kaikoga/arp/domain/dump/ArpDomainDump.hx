package net.kaikoga.arp.domain.dump;

import net.kaikoga.arp.domain.dump.ArpSlotDump.ArpSlotTreeStringPrinter;
import net.kaikoga.arp.domain.core.ArpType;

@:access(net.kaikoga.arp.domain.ArpDomain)
class ArpDomainDump {

	private var domain:ArpDomain;
	private var typeFilter:ArpType -> Bool;

	private function defaultTypeFilter(type:ArpType):Bool return true;

	public function new(domain:ArpDomain, typeFilter:ArpType -> Bool) {
		this.domain = domain;
		if (typeFilter == null) typeFilter = this.defaultTypeFilter;
		this.typeFilter = typeFilter;
	}

	public function dumpSlotStatus():Array<ArpSlotDump> {
		var result:ArpSlotDump = new ArpSlotDump("<root>", "");
		for (slot in domain.slots) {
			result.children.push(new ArpDomainDump(slot));
		}
		return result;
	}

	public function dumpSlotStatusByName(slot:ArpSlot, hashKey:String = null, visitedSlotIds:Array<String> = null):<ArpSlotDump> {
		var result:ArpSlotDump = new ArpSlotDump(slot, hashKey);
		if (visitedSlotIds == null) visitedSlotIds = [];

		var childrenByName:IIndexedMap = slot.childrenByName;
		var child:ArpObjectSlot;
		var name:String;
		var namesToVisit:Array<Dynamic> = [];
		var namesToIndex:Array<Dynamic> = [];
		for (name in Reflect.fields(childrenByName)) {
			child = childrenByName.byName(name);
			if (visitedSlotIds[child.id]) {
				namesToIndex.push(name);
			}
			else {
				visitedSlotIds[child.id] = true;
				namesToVisit.push(name);
			}
		}
		if (namesToVisit.length + namesToIndex.length == 0) {
			return result;
		}
		namesToIndex.sort();
		namesToVisit.sort();
		for (name in namesToVisit) {
			child = childrenByName.byName(name);
			result.children.push(this.dumpSlotStatusByName(child, name, visitedSlotIds));
		}
		for (name in namesToIndex) {
			child = childrenByName.byName(name);
			result.children.push(new ArpObjectSlotStatus(child, name));
		}
		if (slot == this._root) {
			for (child/* AS3HX WARNING could not determine type for var: child exp: EField(EIdent(this),_slots) type: null */ in this._slots) {
				if (!visitedSlotIds[child.id]) {
					result.children.push(new ArpObjectSlotDump(child));
				}
			}
		}
		return result;
	}

	public static var printer(get, never):ArpSlotTreeStringPrinter;
	inline private function get_printer():ArpSlotTreeStringPrinter return new ArpSlotTreeStringPrinter();
}
