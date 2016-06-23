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
		PersistableMapTool.readIntOmap(this, input);
	}

	public function writeSelf(output:IPersistOutput):Void {
		PersistableMapTool.writeIntOmap(this, output);
	}

}
