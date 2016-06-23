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
		PersistableMapTool.readIntOmap(this, input, proto);
	}

	public function writeSelf(output:IPersistOutput):Void {
		PersistableMapTool.writePersistableOmap(this, output);
	}

}
