﻿package net.kaikoga.arp.collections.persistable;

import net.kaikoga.persistable.IPersistInput;
import net.kaikoga.persistable.IPersistOutput;
import net.kaikoga.persistable.IPersistable;

/**
 * ...
 * @author kaikoga
 */
class PersistableStringMap extends IndexedStringMap<String> implements IPersistable {

	public function new() {
		super();
	}

	public function readSelf(input:IPersistInput):Void {
		this.clear();
		var name:String = input.readName();
		while (name != "") {
			this.set(name, input.readUTF(name));
			name = input.readName();
		}
	}

	public function writeSelf(output:IPersistOutput):Void {
		for (name in this._keys) {
			output.writeName(name);
			output.writeUTF(name, this.get(name));
		}
		output.writeName("");
	}

}