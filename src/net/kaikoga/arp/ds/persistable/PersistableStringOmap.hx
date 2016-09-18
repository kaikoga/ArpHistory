package net.kaikoga.arp.ds.persistable;

import net.kaikoga.arp.ds.decorators.OmapDecorator;
import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.persistable.IPersistable;

class PersistableStringOmap extends OmapDecorator<String, String> implements IPersistable {

	public function new(omap:IOmap<String, String>) {
		super(omap);
	}

	public function readSelf(input:IPersistInput):Void {
		PersistableStringOmapTool.readStringOmap(this, input);
	}

	public function writeSelf(output:IPersistOutput):Void {
		PersistableStringOmapTool.writeStringOmap(this, output);
	}

}

class PersistableStringOmapTool {

	inline public static function readStringOmap(omap:IOmap<String, String>, input:IPersistInput):Void {
		omap.clear();
		var nameList:Array<String> = input.readNameList("names");
		var values:IPersistInput = input.readEnter("values");
		for (name in nameList) {
			omap.addPair(name, values.readUtf(name));
		}
		values.readExit();
	}

	inline public static function writeStringOmap(omap:IOmap<String, String>, output:IPersistOutput):Void {
		var nameList:Array<String> = [for (name in omap.keys()) name];
		output.writeNameList("names", nameList);
		var values:IPersistOutput = output.writeEnter("values");
		for (name in nameList) {
			values.writeUtf(name, omap.get(name));
		}
		values.writeExit();
	}
}
