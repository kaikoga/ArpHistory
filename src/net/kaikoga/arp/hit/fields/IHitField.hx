package net.kaikoga.arp.hit.fields;

interface IHitField<Hit, T> {

	public function tick(timeslice:Float = 1.0):Void;

	public function add(owner:T, life:Float = 0.0):Hit;
	public function addOnce(owner:T):Hit;
	public function addEternal(owner:T):Hit;

	public function hitTest(callback:T->T->Bool):Void;
	public function hitRaw(hit:Hit, callback:T->Bool):Void;
}
