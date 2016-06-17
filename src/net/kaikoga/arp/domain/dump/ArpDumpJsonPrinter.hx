package net.kaikoga.arp.domain.dump;

import haxe.Json;
import net.kaikoga.arp.ds.Tree;

class ArpDumpJsonPrinter {

	public function new() {
	}

	public function format(tree:Tree<ArpDump>):String {
		return Json.stringify(new ArpDumpAnonPrinter().format(tree));
	}
}
