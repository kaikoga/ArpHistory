package net.kaikoga.arp.ds.persistable;

import net.kaikoga.arp.ds.decorators.OmapDecorator;
import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.persistable.IPersistable;

/**
 * ...
 * @author kaikoga
 */
class PersistableIntMap extends OmapDecorator<String, Int> implements IPersistable {

	public function new(omap:IOmap<String, Int>) {
		super(omap);
	}

	public function readSelf(input:IPersistInput):Void {
		this.clear();
		for (name in input.readNameList("")) {
			this.addPair(name, input.readInt32(name));
		}
	}

	public function writeSelf(output:IPersistOutput):Void {
		var nameList:Array<String> = [for (name in this.keys()) name];
		output.writeNameList("", nameList);
		for (name in nameList) {
			output.writeInt32(name, this.get(name));
		}
	}

}
