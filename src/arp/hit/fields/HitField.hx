package arp.hit.fields;

import arp.hit.strategies.IHitTester;

// very naive implementation of IHitField, which can handle arbitrary object
class HitField<Hit, T> implements IHitField<Hit, T> {

	private var hitItems:Array<HitItem<Hit, T>>;
	private var hitItemsLength:Int = 0;
	private var strategy:IHitTester<Hit>;

	private var generation:HitGeneration = HitGeneration.Blue;

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
			if (this.generation.preserve(hitItem.generation)) {
				this.hitItems[j++] = hitItem;
			}
		}
		for (i in j...this.hitItems.length) {
			this.hitItems[i] = null;
		}
		this.hitItemsLength = j;
		this.generation.next();
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
		hitItem = new HitItem<Hit, T>(owner, this.generation, hit);
		this.hitItems.push(hitItem);
		this.hitItemsLength++;
		return hit;
	}

	private function doAdd(owner:T, generation:HitGeneration):Hit {
		var hitItem:HitItem<Hit, T>;
		for (i in 0...this.hitItemsLength) {
			hitItem = this.hitItems[i];
			if (hitItem.owner == owner) {
				hitItem.generation = generation;
				return hitItem.hit;
			}
		}

		var hit:Hit = this.strategy.createHit();
		hitItem = new HitItem<Hit, T>(owner, generation, hit);
		this.hitItems.push(hitItem);
		this.hitItemsLength++;
		return hit;
	}

	public function add(owner:T):Hit {
		return doAdd(owner, this.generation);
	}

	public function addEternal(owner:T):Hit {
		return doAdd(owner, HitGeneration.Eternal);
	}

	public function hitTest(callback:(a:T, b:T)->Bool):Void {
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
	public var hit:Hit;

	@:allow(arp.hit.fields.HitField)
	private var generation:HitGeneration;

	public function new(owner:T, generation:HitGeneration, hit:Hit) {
		this.owner = owner;
		this.generation = generation;
		this.hit = hit;
	}
}
