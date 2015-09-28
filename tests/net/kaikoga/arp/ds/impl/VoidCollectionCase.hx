package net.kaikoga.arp.ds.impl;

class VoidCollectionCase {

	private var set:VoidSet<Int>;
	private var list:VoidList<Int>;
	private var map:VoidMap<Int, Int>;
	private var mapList:VoidMapList<Int, Int>;

	public function setup():Void {
		set = new VoidSet();
		list = new VoidList();
		map = new VoidMap();
		mapList = new VoidMapList();
	}

	public function test():Void {
	}
}
