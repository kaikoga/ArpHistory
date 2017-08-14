package net.kaikoga.arp.hit.fields;

import net.kaikoga.arp.hit.strategies.IHitTester;

// very naive implementation of IHitField, which handles HitObjects
class HitObjectField<Hit, T:HitObject<Hit>> implements IHitField<Hit, T> {

	private var hitObjects:Array<T>;
	private var hitObjectsLength:Int = 0;
	private var strategy:IHitTester<Hit>;

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
			if ((hitObject.life -= timeslice) > 0.0) {
				this.hitObjects[j++] = hitObject;
			}
		}
		for (i in j...this.hitObjects.length) {
			this.hitObjects[i] = null;
		}
		this.hitObjectsLength = j;
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
		owner.life = 0.0;
		owner.hit = hit;
		this.hitObjects[this.hitObjectsLength++] = owner;
		return hit;
	}

	public function add(owner:T, life:Float = 0.0):Hit {
		var hitObject:T;
		for (i in 0...this.hitObjectsLength) {
			hitObject = this.hitObjects[i];
			if (hitObject == owner) {
				if (hitObject.life < life) hitObject.life = life;
				return hitObject.hit;
			}
		}

		var hit:Hit = this.strategy.createHit();
		owner.life = life;
		owner.hit = hit;
		this.hitObjects[this.hitObjectsLength++] = owner;
		return hit;
	}

	public function addOnce(owner:T):Hit {
		return add(owner, 0);
	}

	public function addEternal(owner:T):Hit {
		return add(owner, Math.POSITIVE_INFINITY);
	}

	public function hitTest(callback:T->T->Bool):Void {
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

