package net.kaikoga.arp.hit.fields;

import net.kaikoga.arp.hit.strategies.IHitTester;

// very naive implementation of IHitField
class HitField<T, Hit> implements IHitField<T, Hit> {

	private var hitItems:Array<HitItem<T, Hit>>;
	private var hitItemsLength:Int = 0;
	private var strategy:IHitTester<Hit>;

	public function new(strategy:IHitTester<Hit>) {
		this.hitItems = [];
		this.strategy = strategy;
	}

	public function tick(timeslice:Float = 1.0):Void {
		var j:Int = 0;
		for (i in 0...this.hitItemsLength) {
			var hitItem:HitItem<T, Hit> = this.hitItems[i];
			if ((hitItem.life -= timeslice) > 0.0) {
				this.hitItems[j++] = hitItem;
			}
		}
		for (i in j...this.hitItemsLength) {
			this.hitItems[i] = null;
		}
		this.hitItemsLength = j;
	}

	public function add(owner:T, life:Float = 0.0):Hit {
		var hitItem:HitItem<T, Hit>;
		for (i in 0...this.hitItemsLength) {
			hitItem = this.hitItems[i];
			if (hitItem.owner == owner) {
				if (hitItem.life < life) hitItem.life = life;
				return hitItem.hit;
			}
		}

		var hit:Hit = this.strategy.createHit();
		hitItem = new HitItem<T, Hit>(owner, life, hit);
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
			var obj:HitItem<T, Hit> = this.hitItems[i];
			for (j in (i + 1)...hitItemsLength) {
				var other:HitItem<T, Hit> = this.hitItems[j];
				if (strategy.collides(obj.hit, other.hit)) {
					if (callback(obj.owner, other.owner)) return;
				}
			}
		}
	}

	public function hitRaw(hit:Hit, callback:T->Bool):Void {
		for (other in this.hitItems) {
			if (other.hit == hit) continue;
			if (strategy.collides(hit, other.hit)) {
				if (callback(other.owner)) return;
			}
		}
	}
}

private class HitItem<T, Hit> {

	public var owner:T;
	public var life:Float = 0;
	public var hit:Hit;

	public function new(owner:T, life:Float, hit:Hit) {
		this.owner = owner;
		this.life = life;
		this.hit = hit;
	}
}

