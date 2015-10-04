package net.kaikoga.arp.ds.persistable;

import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.persistable.IPersistable;

/**
 * ...
 * @author kaikoga
 */
class PersistableMap<V:IMappedPersistable> extends MapList<String, V> implements IPersistable {

	private var proto:V;

	public function new(proto:V) {
		super();
		this.proto = proto;
	}

	public function readSelf(input:IPersistInput):Void {
		var name:String = input.readName();
		while (name != "") {
			var element:V = this.get(name);
			if (element == null) {
				element = cast proto.clonePersistable(name);
				this.addPair(name, element);
			}
			input.readPersistable(name, element);
			name = input.readName();
		}
	}

	public function writeSelf(output:IPersistOutput):Void {
		for (name in this._keys) {
			output.writeName(name);
			output.writePersistable(name, this.get(name));
		}
		output.writeName("");
	}

}
