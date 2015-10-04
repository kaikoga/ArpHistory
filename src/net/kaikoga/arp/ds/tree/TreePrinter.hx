package net.kaikoga.arp.ds.tree;

import net.kaikoga.arp.ds.TreeItem;

class TreePrinter<V,T:TreeItem<V>> implements ITreePrinter<V,T> {

	public function new() {
	}

	public function format(tree:Array<T>, depth:Int = -1, level:Int = 0):Dynamic {
		var result:String = "";
		var c:Int = tree.length;
		var indent:String = StringTools.lpad("", " ", level * 2);
		for (i in 0...c) {
			var item:T = tree[i];
			if (depth != 0 && item.hasChildren) {
				result += indent + item.value + "{\n";
				result += format(item.children, depth - 1, level + 1);
				result += indent + "}\n";
			} else {
				result += indent + Std.string(item.value) + "\n";
			}
		}
		return result;
	}
}

