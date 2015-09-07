package net.kaikoga.arp.persistable;

import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;

interface IPersistable {
	function readSelf(input:IPersistInput):Void;
	function writeSelf(output:IPersistOutput):Void;
}


