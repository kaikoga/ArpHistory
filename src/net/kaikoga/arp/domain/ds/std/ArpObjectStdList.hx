package net.kaikoga.arp.domain.ds.std;

class ArpObjectStdList<T:IArpObject> extends List<T> {

	private var domain:ArpDomain;

	public function new(domain:ArpDomain) {
		super();
		this.domain = domain;
	}

	override public function add(item:T) {
		item.arpSlot().addReference();
		super.add();
	}

	override public function push(item:T) {
		item.arpSlot().addReference();
		super.push();
	}

	override public function pop():Null<T> {
		var item:T = super.pop();
		if (item != null) item.arpSlot().delReference();
		return item;
	}

	override public function clear():Void {
		for (item in this) item.arpSlot().delReference();
		super.clear();
	}

	override public function remove(v:T):Bool {
		v.arpSlot().delReference();
		return super.remove(v);
	}

}
