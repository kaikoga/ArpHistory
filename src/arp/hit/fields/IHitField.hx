package arp.hit.fields;

interface IHitField<Hit, T> {

	public var size(get, never):Int;

	public function tick(timeslice:Float = 1.0):Void;

	public function add(owner:T):Hit;
	public function addEternal(owner:T):Hit;

	public function hitTest(callback:(a:T, b:T)->Bool):Void;
	public function hitRaw(hit:Hit, callback:T->Bool):Void;
}
