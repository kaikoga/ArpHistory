package net.kaikoga.arp.ds.persistable;

import net.kaikoga.arp.ds.decorators.OmapDecorator;
import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.persistable.IPersistable;

/**
 * ...
 * @author kaikoga
 */
class PersistableStringMap extends OmapDecorator<String, String> implements IPersistable {

	public function new(omap:IOmap<String, String>) {
		super(omap);
	}

	public function readSelf(input:IPersistInput):Void {
		PersistableMapTool.readStringOmap(this, input);
	}

	public function writeSelf(output:IPersistOutput):Void {
		PersistableMapTool.writeStringOmap(this, output);
	}

}
