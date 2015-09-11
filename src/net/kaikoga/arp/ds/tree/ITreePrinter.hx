package net.kaikoga.arp.ds.tree;

import net.kaikoga.arp.ds.TreeItem;

interface ITreePrinter<T:TreeItem<V>> {
	function format(tree:Array<T>, depth:Int = -1, level:Int = 0):Dynamic;
}

