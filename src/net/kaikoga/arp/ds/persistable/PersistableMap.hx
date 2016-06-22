package net.kaikoga.arp.ds.persistable;

import net.kaikoga.arp.ds.decorators.OmapDecorator;
import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.persistable.IPersistable;

/**
 * ...
 * @author kaikoga
 */
class PersistableMap<V:IMappedPersistable> extends OmapDecorator<String, V> implements IPersistable {

	private var proto:V;

	public function new(omap:IOmap<String, V>, proto:V) {
		super();
		this.proto = proto;
	}

	public function readSelf(input:IPersistInput):Void {
		for (name in input.readNameList("")) {
			var element:V = this.get(name);
			if (element == null) {
				element = cast proto.clonePersistable(name);
				this.addPair(name, element);
			}
			input.readPersistable(name, element);
		}
	}

	public function writeSelf(output:IPersistOutput):Void {
		var nameList:Array<String> = [for (name in this.keys()) name];
		output.writeNameList("", nameList);
		for (name in nameList) {
			output.writePersistable(name, this.get(name));
		}
	}

}
