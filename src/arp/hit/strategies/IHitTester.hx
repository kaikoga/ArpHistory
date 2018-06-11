package arp.hit.strategies;

//@:generic
interface IHitTester<Hit> {
	public function createHit():Hit;
	public function collides(a:Hit, b:Hit):Bool;
}
