package net.kaikoga.arp.ds.persistable;

import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.persistable.IPersistable;

/**
 * ...
 * @author kaikoga
 */
class PersistableStringMap extends MapList<String, String> implements IPersistable {

	public function new() {
		super();
	}

	public function readSelf(input:IPersistInput):Void {
		this.clear();
		var name:String = input.readName();
		while (name != "") {
			this.set(name, input.readUtf(name));
			name = input.readName();
		}
	}

	public function writeSelf(output:IPersistOutput):Void {
		for (name in this._keys) {
			output.writeName(name);
			output.writeUtf(name, this.get(name));
		}
		output.writeName("");
	}

}
