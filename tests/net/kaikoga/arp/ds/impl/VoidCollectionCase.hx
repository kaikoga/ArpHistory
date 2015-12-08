package net.kaikoga.arp.ds.impl;

class VoidCollectionCase {

	private var set:VoidSet<Int>;
	private var list:VoidList<Int>;
	private var map:VoidMap<Int, Int>;
	private var mapList:VoidOmap<Int, Int>;

	public function setup():Void {
		set = new VoidSet();
		list = new VoidList();
		map = new VoidMap();
		mapList = new VoidOmap();
	}

	public function test():Void {
		
	}
}
