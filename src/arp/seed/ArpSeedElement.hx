package arp.seed;

import arp.iterators.SimpleArrayIterator;

class ArpSeedElement {

	public var className(default, null):String;
	public var name(default, null):String;
	public var heat(default, null):String;

	public var isSimple(default, null):Bool = true;
	public var value(default, null):Null<String>;
	public var valueKind(get, never):ArpSeedValueKind;
	private function get_valueKind():ArpSeedValueKind return if (this.isSimple) ArpSeedValueKind.Literal else ArpSeedValueKind.None;

	private var children:Array<ArpSeed>;

	public function new(className:String, name:String, heat:String, children:Array<ArpSeed>) {
		this.className = className;
		this.name = name;
		this.heat = heat;
		this.children = children;
		for (child in children) {
			if (child.typeName == "value") {
				this.value = child.value;
			} else {
				isSimple = false;
				this.value = null;
				break;
			}
		}
	}

	public function iterator():Iterator<ArpSeed> return new SimpleArrayIterator(this.children);
}
