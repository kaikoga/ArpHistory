package arp.seed;

import arp.iterators.SimpleArrayIterator;

class ArpSeedElement {

	public var className(default, null):String;
	public var name(default, null):String;
	public var heat(default, null):String;

	private var children:Array<ArpSeed>;

	public function new(className:String, name:String, heat:String, children:Array<ArpSeed>) {
		this.className = className;
		this.name = name;
		this.heat = heat;
		this.children = children;
	}

	public function iterator():Iterator<ArpSeed> return new SimpleArrayIterator(this.children);
}
