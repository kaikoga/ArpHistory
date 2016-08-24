package net.kaikoga.arp.hit.fields;

import net.kaikoga.arp.hit.fields.HitObject;

class TestHitObject<Hit> extends HitObject<Hit> {

	public var name:String;

	public function new(name:String) {
		super();
		this.name = name;
	}
}
