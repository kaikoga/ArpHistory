package net.kaikoga.arpx.mortal;

import net.kaikoga.arp.task.ITickable;
import net.kaikoga.arp.ds.impl.ArraySet;
import net.kaikoga.arp.ds.ISet;
import net.kaikoga.arp.hit.structs.HitGeneric;
import net.kaikoga.arp.hit.fields.HitObject;
import net.kaikoga.arpx.motion.Motion;
import net.kaikoga.arpx.driver.Driver;
import net.kaikoga.arp.domain.ArpDirectory;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.hitFrame.HitFrame;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.reactFrame.ReactFrame;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.mortal.IMortalFlashImpl;
#end

@:arpType("mortal", "null")
class Mortal implements IArpObject implements ITickable
#if (arp_backend_flash || arp_backend_openfl) implements IMortalFlashImpl #end
{

	@:arpBarrier @:arpField public var driver:Driver;
	@:arpField public var position:ArpPosition;
	@:arpField public var visible:Bool = true;
	@:arpField public var params:ArpParams;
	@:arpBarrier @:arpField("hitFrame") public var hitFrames:ISet<HitFrame>;

	@:arpField(false) private var _field:Field;
	public var field(get, never):Field;
	inline private function get_field():Field return this._field;

	private var hitMortals:Map<String, HitMortal>;
	private var reactRecord:ISet<String>;
	private var lastReactRecord:ISet<String>;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:IMortalFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new () {
		hitMortals = new Map<String, HitMortal>();
		reactRecord = new ArraySet<String>();
		lastReactRecord = new ArraySet<String>();
	}

	private var isComplex(get, never):Bool;
	private function get_isComplex():Bool return false;

	public function asHitType(hitType:String):HitMortal {
		if (hitMortals.exists(hitType)) return hitMortals.get(hitType);
		var hitMortal:HitMortal = new HitMortal(this, hitType, this.isComplex);
		hitMortals.set(hitType, hitMortal);
		return hitMortal;
	}

	public function tick(timeslice:Float):Bool {
		if (this.driver != null) {
			this.driver.tick(this.field, this);
		} else {
			refreshHitMortals(this.field);
		}

		var rr = this.lastReactRecord;
		if (!rr.isEmpty()) rr.clear();
		this.lastReactRecord = reactRecord;
		this.reactRecord = rr;
		return true;
	}

	public function startAction(actionName:String, restart:Bool = false):Bool {
		return this.driver.startAction(this, actionName, restart);
	}

	public function onStartAction(actionName:String, newMotion:Motion):Void {

	}

	public function react(field:Field, source:Mortal, reactFrame:ReactFrame, delay:Float):Void {
		var reactionName:String = source.arpSlot.sid + ArpDirectory.PATH_DELIMITER + reactFrame.arpSlot.sid;
		if (!this.lastReactRecord.hasValue(reactionName)) {
			this.onReact(field, source, reactFrame, delay);
		}
		this.reactRecord.add(reactionName);
		this.lastReactRecord.add(reactionName);
	}

	public function onReact(field:Field, source:Mortal, reactFrame:ReactFrame, delay:Float):Void {

	}

	public function collide(field:Field, source:Mortal):Void {
		var reactionName:String = source.arpSlot.sid.toString();
		if (!this.lastReactRecord.hasValue(reactionName)) {
			this.onCollide(field, source);
		}
		this.reactRecord.add(reactionName);
		this.lastReactRecord.add(reactionName);
	}

	public function onCollide(field:Field, source:Mortal):Void {

	}

	private function refreshHitMortals(field:Field):Void {
		for (hitFrame in this.hitFrames) hitFrame.updateHitMortal(field, this);
	}

	@:access(net.kaikoga.arpx.field.Field.hitField)
	public function moveWithHit(field:Field, x:Float, y:Float, z:Float, dHitType:String):Void {
		if (dHitType == null) {
			this.position.x = x;
			this.position.y = y;
			this.position.z = z;
			return;
		}

		var hit:HitGeneric = field.findHit(this, dHitType);
		var p:Float;

		p = this.position.x;
		this.position.x = x;
		this.refreshHitMortals(field);
		field.hitRaw(hit, dHitType, function(other:HitMortal):Bool {
			this.collide(field, other.mortal);
			this.position.x = p;
			return true;
		});

		p = this.position.y;
		this.position.y = y;
		this.refreshHitMortals(field);
		field.hitRaw(hit, dHitType, function(other:HitMortal):Bool {
			this.collide(field, other.mortal);
			this.position.y = p;
			return true;
		});

		p = this.position.z;
		this.position.z = z;
		this.refreshHitMortals(field);
		field.hitRaw(hit, dHitType, function(other:HitMortal):Bool {
			this.collide(field, other.mortal);
			this.position.z = p;
			this.refreshHitMortals(field);
			return true;
		});
	}

	public function moveDWithHit(field:Field, dX:Float, dY:Float, dZ:Float, dHitType:String):Void {
		this.moveWithHit(
			field,
			this.position.x + dX,
			this.position.y + dY,
			this.position.z + dZ,
			dHitType
		);
	}

	public function stayWithHit(field:Field, dHitType:String):Void {
		this.refreshHitMortals(field);
	}

	public function complexHitTest(self:HitGeneric, other:HitGeneric):Bool {
		return true;
	}
}

class HitMortal extends HitObject<HitGeneric> {

	public var mortal:Mortal;
	public var hitType:String;
	public var isComplex:Bool;

	public function new(mortal:Mortal, hitType:String, isComplex:Bool) {
		super();
		this.mortal = mortal;
		this.hitType = hitType;
		this.isComplex = isComplex;
	}
}
