package net.kaikoga.arp.ds.persistable;

import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.persistable.IPersistable;

/**
 * ...
 * @author kaikoga
 */
class PersistableIntMap extends MapList<String, Int> implements IPersistable {

	public function new() {
		super();
	}

	public function readSelf(input:IPersistInput):Void {
		this.clear();
		var name:String = input.readName();
		while (name != "") {
			this.addPair(name, input.readInt32(name));
			name = input.readName();
		}
	}

	public function writeSelf(output:IPersistOutput):Void {
		for (name in this._keys) {
			output.writeName(name);
			output.writeInt32(name, this.get(name));
		}
		output.writeName("");
	}

}
