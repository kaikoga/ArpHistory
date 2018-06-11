package arp.hit.fields;

import arp.hit.strategies.IHitTester;

// very naive implementation of IHitField, which handles HitObjects
class HitObjectField<Hit, T:HitObject<Hit>> implements IHitField<Hit, T> {

	private var hitObjects:Array<T>;
	private var hitObjectsLength:Int = 0;
	private var strategy:IHitTester<Hit>;

	private var generation:HitGeneration = HitGeneration.Blue;

	public var size(get, never):Int;
	private function get_size():Int return this.hitObjectsLength;

	public function new(strategy:IHitTester<Hit>) {
		this.hitObjects = [];
		this.strategy = strategy;
	}

	public function tick(timeslice:Float = 1.0):Void {
		var j:Int = 0;
		for (i in 0...this.hitObjectsLength) {
			var hitObject:T = this.hitObjects[i];
			if (this.generation.preserve(hitObject.generation)) {
				this.hitObjects[j++] = hitObject;
			}
		}
		for (i in j...this.hitObjects.length) {
			this.hitObjects[i] = null;
		}
		this.hitObjectsLength = j;
		this.generation.next();
	}

	public function find(owner:T):Hit {
		var hitObject:T;
		for (i in 0...this.hitObjectsLength) {
			hitObject = this.hitObjects[i];
			if (hitObject == owner) {
				return hitObject.hit;
			}
		}

		var hit:Hit = this.strategy.createHit();
		owner.generation = this.generation;
		owner.hit = hit;
		this.hitObjects[this.hitObjectsLength++] = owner;
		return hit;
	}

	private function doAdd(owner:T, generation:HitGeneration):Hit {
		var hitObject:T;
		for (i in 0...this.hitObjectsLength) {
			hitObject = this.hitObjects[i];
			if (hitObject == owner) {
				hitObject.generation = generation;
				return hitObject.hit;
			}
		}

		var hit:Hit = this.strategy.createHit();
		owner.generation = generation;
		owner.hit = hit;
		this.hitObjects[this.hitObjectsLength++] = owner;
		return hit;
	}

	public function add(owner:T):Hit {
		return doAdd(owner, this.generation);
	}

	public function addEternal(owner:T):Hit {
		return doAdd(owner, HitGeneration.Eternal);
	}

	public function hitTest(callback:(a:T, b:T)->Bool):Void {
		for (i in 0...(this.hitObjectsLength - 1)) {
			var obj:T = this.hitObjects[i];
			for (j in (i + 1)...hitObjectsLength) {
				var other:T = this.hitObjects[j];
				if (strategy.collides(obj.hit, other.hit)) {
					if (callback(obj, other)) return;
				}
			}
		}
	}

	public function hitRaw(hit:Hit, callback:T->Bool):Void {
		for (i in 0...this.hitObjectsLength) {
			var other:T = this.hitObjects[i];
			if (other.hit == hit) continue;
			if (strategy.collides(hit, other.hit)) {
				if (callback(other)) return;
			}
		}
	}
}

