package net.kaikoga.arp.domain.dump;

import net.kaikoga.arp.ds.Tree;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
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

	public function dumpSlotStatus():Tree<ArpSlotDump> {
		var result:Tree<ArpSlotDump> = ArpSlotDump.ofDir(null, null);
		for (slot in domain.slots) {
			result.children.push(ArpSlotDump.ofSlot(slot, null));
		}
		result.children.sort(ArpSlotDump.compareTreeId);
		return result;
	}

	@:access(net.kaikoga.arp.domain.ArpDirectory)
	public function dumpSlotStatusByName(dir:ArpDirectory = null, hashKey:String = null, visitedSlotIds:Map<String, Bool> = null):Tree<ArpSlotDump> {
		if (dir == null) dir = this.domain.root;
		var result:Tree<ArpSlotDump> = ArpSlotDump.ofDir(dir, hashKey);
		if (visitedSlotIds == null) visitedSlotIds = new Map();

		var children:Map<String, ArpDirectory> = dir.children;
		var slotNames:Array<String> = [for (key in children.keys()) key];
		slotNames.sort(compareString);
		for (name in slotNames) result.children.push(dumpSlotStatusByName(children.get(name), name, visitedSlotIds));

		var namesToVisit:Array<String> = [];
		var namesToIndex:Array<String> = [];
		var slots:Map<String, ArpUntypedSlot> = dir.slots;
		for (name in slots.keys()) {
			var slot:ArpUntypedSlot = slots.get(name);
			if (visitedSlotIds.exists(slot.sid.toString())) {
				namesToIndex.push(name);
			} else {
				visitedSlotIds.set(slot.sid.toString(), true);
				namesToVisit.push(name);
			}
		}
		if (namesToVisit.length > 0) {
			namesToVisit.sort(compareString);
			for (name in namesToVisit) {
				result.children.push(ArpSlotDump.ofSlot(slots.get(name), '<$name>'));
			}
		}
		if (namesToIndex.length > 0) {
			namesToIndex.sort(compareString);
			for (name in namesToIndex) {
				result.children.push(ArpSlotDump.ofSlot(slots.get(name), '<$name>'));
			}
		}
		if (dir == this.domain.root) {
			for (child in this.domain.slots) {
				if (!visitedSlotIds.exists(child.sid.toString())) {
					result.children.push(ArpSlotDump.ofSlot(child, '</>'));
				}
			}
		}
		return result;
	}

	public static function compareString(a:String, b:String):Int {
		if (a > b) return 1;
		if (a < b) return -1;
		return 0;
	}

	public static var printer(get, never):ArpSlotTreeStringPrinter;
	inline private static function get_printer():ArpSlotTreeStringPrinter return new ArpSlotTreeStringPrinter();

	public static var anonPrinter(get, never):ArpSlotTreeAnonPrinter;
	inline private static function get_anonPrinter():ArpSlotTreeAnonPrinter return new ArpSlotTreeAnonPrinter();

	public static var jsonPrinter(get, never):ArpSlotTreeJsonPrinter;
	inline private static function get_jsonPrinter():ArpSlotTreeJsonPrinter return new ArpSlotTreeJsonPrinter();
}
