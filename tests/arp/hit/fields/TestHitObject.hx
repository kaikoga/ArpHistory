package arp.hit.fields;

import arp.hit.fields.HitObject;

class TestHitObject<Hit> extends HitObject<Hit> {

	public var name:String;

	public function new(name:String) {
		super();
		this.name = name;
	}
}
