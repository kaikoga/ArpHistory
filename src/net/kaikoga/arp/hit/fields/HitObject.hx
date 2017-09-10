package net.kaikoga.arp.hit.fields;

// HitObject is direct owner of hit
class HitObject<Hit> {

	@:allow(net.kaikoga.arp.hit.fields.HitObjectField)
	private var generation:HitGeneration;

	public var hit:Hit;

	public function new() {
	}
}
