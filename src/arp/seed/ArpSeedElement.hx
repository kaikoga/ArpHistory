package arp.seed;

import arp.iterators.SimpleArrayIterator;

class ArpSeedElement {

	public var className(default, null):String;
	public var name(default, null):String;
	public var heat(default, null):String;

	public var isSimple(default, null):Bool = true;

	private var children:Array<ArpSeed>;
	private var delegate:Null<ArpSeed>;

	public var key(get, never):String;
	inline private function get_key():Null<String> return if (delegate != null) delegate.key else null;
	public var value(get, never):String;
	inline private function get_value():Null<String> return if (delegate != null) delegate.value else null;

	public function new(className:String, name:String, heat:String, children:Array<ArpSeed>) {
		this.className = className;
		this.name = name;
		this.heat = heat;
		this.children = children;
		for (child in children) {
			if (child.typeName == "value") {
				this.delegate = child;
			} else {
				isSimple = false;
				this.delegate = null;
				break;
			}
		}
	}

	public function iterator():Iterator<ArpSeed> return new SimpleArrayIterator(this.children);
}
