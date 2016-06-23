package net.kaikoga.arp.ds.persistable;

import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;

/**
 * ...
 * @author kaikoga
 */
class PersistableMapTool {

	inline public static function readIntOmap(omap:IOmap<String, Int>, input:IPersistInput):Void {
		omap.clear();
		var nameList:Array<String> = input.readNameList("names");
		var values:IPersistInput = input.readEnter("values");
		for (name in nameList) {
			omap.addPair(name, values.readInt32(name));
		}
		values.readExit();
	}

	inline public static function writeIntOmap(omap:IOmap<String, Int>, output:IPersistOutput):Void {
		var nameList:Array<String> = [for (name in omap.keys()) name];
		output.writeNameList("names", nameList);
		var values:IPersistOutput = output.writeEnter("values");
		for (name in nameList) {
			output.writeInt32(name, omap.get(name));
		}
		values.writeExit();
	}

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

	inline public static function readPersistableOmap<V:IMappedPersistable>(omap:IOmap<String, V>, input:IPersistInput, proto:V):Void {
		omap.clear();
		var nameList:Array<String> = input.readNameList("names");
		var values:IPersistInput = input.readEnter("values");
		for (name in nameList) {
			var element:V = omap.get(name);
			if (element == null) {
				element = cast proto.clonePersistable(name);
				omap.addPair(name, element);
			}
			values.readPersistable(name, element);
		}
		values.readExit();
	}

	inline public static function writePersistableOmap<V:IMappedPersistable>(omap:IOmap<String, V>, output:IPersistOutput):Void {
		var nameList:Array<String> = [for (name in omap.keys()) name];
		output.writeNameList("names", nameList);
		var values:IPersistOutput = output.writeEnter("values");
		for (name in nameList) {
			values.writePersistable(name, omap.get(name));
		}
		values.writeExit();
	}

}
