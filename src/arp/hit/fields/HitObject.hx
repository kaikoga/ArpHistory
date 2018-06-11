package arp.hit.fields;

// HitObject is direct owner of hit
class HitObject<Hit> {

	@:allow(arp.hit.fields.HitObjectField)
	private var generation:HitGeneration;

	public var hit:Hit;

	public function new() {
	}
}
