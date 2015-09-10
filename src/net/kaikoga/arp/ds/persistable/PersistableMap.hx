package net.kaikoga.arp.collections.persistable;

import net.kaikoga.persistable.IPersistInput;
import net.kaikoga.persistable.IPersistOutput;
import net.kaikoga.persistable.IPersistable;

/**
 * ...
 * @author kaikoga
 */
class PersistableMap<V:IPersistable> extends IndexedStringMap<V> implements IPersistable {

	private var proto:IMappedPersistable;

	public function new(proto:IMappedPersistable) {
		super();
		this.proto = proto;
	}

	public function readSelf(input:IPersistInput):Void {
		var name:String = input.readName();
		while (name != "") {
			var element:IMappedPersistable = this.get(name);
			if (!element) {
				element = proto.clonePersistable(name);
				this.set(name, element);
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
