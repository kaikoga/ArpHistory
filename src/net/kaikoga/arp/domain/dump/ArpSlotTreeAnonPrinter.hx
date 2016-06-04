package net.kaikoga.arp.domain.dump;

import net.kaikoga.arp.ds.Tree;
import net.kaikoga.arp.ds.tree.ITreePrinter;

class ArpSlotTreeAnonPrinter implements ITreePrinter<ArpSlotDump, {}> {

	public function new() {
	}

	public function format(tree:Tree<ArpSlotDump>, depth:Int = -1, level:Int = 0):{} {
		var names:Array<String> = [];

		var result:Dynamic = {};
		Reflect.setField(result, "", names);
		for (i in 0...tree.children.length) {
			var child:Tree<ArpSlotDump> = tree.children[i];
			var entry:Dynamic = {
				status: child.value.status,
				template: "slot.arpTemplateName",
				value: child.value.id,
				refCount: child.value.refCount
			};
			if (depth != 0 && tree.hasChildren) {
				Reflect.setField(entry, "children", format(child, depth - 1, level + 1));
			}
			var name:String = child.value.hashKey;
			if (name == null) name = '@$i';
			names.push(name);
			Reflect.setField(result, name, entry);
		}
		return result;
	}
}
