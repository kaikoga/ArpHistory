package net.kaikoga.arp.domain.dump;

import haxe.Json;
import net.kaikoga.arp.ds.Tree;

class ArpSlotTreeJsonPrinter {

	public function new() {
	}

	public function format(tree:Tree<ArpSlotDump>):{} {
		return Json.stringify(new ArpSlotTreeAnonPrinter().format(tree));
	}
}
