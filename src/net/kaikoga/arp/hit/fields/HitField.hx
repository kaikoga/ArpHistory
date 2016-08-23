package net.kaikoga.arp.hit.fields;

import net.kaikoga.arp.hit.strategies.IHitTester;

class HitField<T, Hit> {

	private var hitItems:Array<HitItem<T, Hit>>;
	private var strategy:IHitTester<Hit>;

	public function new(strategy:IHitTester<Hit>) {
		this.hitItems = [];
		this.strategy = strategy;
	}

	public function add(owner:T, hit:Hit):Void {
		this.hitItems.push(new HitItem(owner, hit));
	}

	public function hitTest(callback:T->T->Bool):Void {
		for (i in 0...(hitItems.length - 1)) {
			var obj:HitItem<T, Hit> = hitItems[i];
			for (j in (i + 1)...hitItems.length) {
				var other:HitItem<T, Hit> = hitItems[j];
				if (strategy.collides(obj.hit, other.hit)) {
					if (callback(obj.owner, other.owner)) return;
				}
			}
		}
	}

	public function hitRaw(hit:Hit, callback:T->Bool):Void {
		for (other in hitItems) {
			if (other.hit == hit) continue;
			if (strategy.collides(hit, other.hit)) {
				if (callback(other.owner)) return;
			}
		}
	}
}

private class HitItem<T, Hit> {

	public var owner:T;
	public var hit:Hit;

	public function new(owner:T, hit:Hit) {
		this.owner = owner;
		this.hit = hit;
	}
}

