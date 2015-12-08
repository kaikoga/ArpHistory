package net.kaikoga.arp.ds.impl.base;

class BaseCollectionCase {

	private var set:BaseSet<Int>;
	private var list:BaseList<Int>;
	private var map:BaseMap<Int, Int>;
	private var mapList:BaseOmap<Int, Int>;

	public function setup():Void {
		set = new BaseSet();
		list = new BaseList();
		map = new BaseMap();
		mapList = new BaseOmap();
	}

	public function test():Void {
	}
}
