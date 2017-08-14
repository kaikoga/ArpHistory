package net.kaikoga.arp.hit.fields;

import net.kaikoga.arp.hit.strategies.IHitTester;

// very naive implementation of IHitField, which can handle arbitrary object
class HitField<Hit, T> implements IHitField<Hit, T> {

	private var hitItems:Array<HitItem<Hit, T>>;
	private var hitItemsLength:Int = 0;
	private var strategy:IHitTester<Hit>;

	public var size(get, never):Int;
	private function get_size():Int return this.hitItemsLength;

	public function new(strategy:IHitTester<Hit>) {
		this.hitItems = [];
		this.strategy = strategy;
	}

	public function tick(timeslice:Float = 1.0):Void {
		var j:Int = 0;
		for (i in 0...this.hitItemsLength) {
			var hitItem:HitItem<Hit, T> = this.hitItems[i];
			if ((hitItem.life -= timeslice) > 0.0) {
				this.hitItems[j++] = hitItem;
			}
		}
		for (i in j...this.hitItems.length) {
			this.hitItems[i] = null;
		}
		this.hitItemsLength = j;
	}

	public function find(owner:T):Hit {
		var hitItem:HitItem<Hit, T>;
		for (i in 0...this.hitItemsLength) {
			hitItem = this.hitItems[i];
			if (hitItem.owner == owner) {
				return hitItem.hit;
			}
		}

		var hit:Hit = this.strategy.createHit();
		hitItem = new HitItem<Hit, T>(owner, 0.0, hit);
		this.hitItems.push(hitItem);
		this.hitItemsLength++;
		return hit;
	}

	public function add(owner:T, life:Float = 0.0):Hit {
		var hitItem:HitItem<Hit, T>;
		for (i in 0...this.hitItemsLength) {
			hitItem = this.hitItems[i];
			if (hitItem.owner == owner) {
				if (hitItem.life < life) hitItem.life = life;
				return hitItem.hit;
			}
		}

		var hit:Hit = this.strategy.createHit();
		hitItem = new HitItem<Hit, T>(owner, life, hit);
		this.hitItems.push(hitItem);
		this.hitItemsLength++;
		return hit;
	}

	public function addOnce(owner:T):Hit {
		return add(owner, 0);
	}

	public function addEternal(owner:T):Hit {
		return add(owner, Math.POSITIVE_INFINITY);
	}

	public function hitTest(callback:T->T->Bool):Void {
		for (i in 0...(this.hitItemsLength - 1)) {
			var obj:HitItem<Hit, T> = this.hitItems[i];
			for (j in (i + 1)...hitItemsLength) {
				var other:HitItem<Hit, T> = this.hitItems[j];
				if (strategy.collides(obj.hit, other.hit)) {
					if (callback(obj.owner, other.owner)) return;
				}
			}
		}
	}

	public function hitRaw(hit:Hit, callback:T->Bool):Void {
		for (i in 0...this.hitItemsLength) {
			var other:HitItem<Hit, T> = this.hitItems[i];
			if (other.hit == hit) continue;
			if (strategy.collides(hit, other.hit)) {
				if (callback(other.owner)) return;
			}
		}
	}
}

private class HitItem<Hit, T> {

	public var owner:T;
	public var life:Float = 0;
	public var hit:Hit;

	public function new(owner:T, life:Float, hit:Hit) {
		this.owner = owner;
		this.life = life;
		this.hit = hit;
	}
}
