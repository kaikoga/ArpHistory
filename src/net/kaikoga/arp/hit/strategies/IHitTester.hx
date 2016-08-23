package net.kaikoga.arp.hit.strategies;

//@:generic
interface IHitTester<Hit> {
	public function collides(a:Hit, b:Hit):Bool;
}
