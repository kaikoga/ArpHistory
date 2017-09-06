package net.kaikoga.arpx.field;

import net.kaikoga.arp.ds.decorators.OmapDecorator;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.ds.lambda.OmapOp;
import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arp.hit.fields.HitObjectField;
import net.kaikoga.arp.hit.strategies.HitWithCuboid;
import net.kaikoga.arp.hit.structs.HitGeneric;
import net.kaikoga.arp.hit.fields.HitField;
import net.kaikoga.arpx.anchor.Anchor;
import net.kaikoga.arpx.mortal.Mortal;
import net.kaikoga.arpx.reactFrame.ReactFrame;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.field.IFieldFlashImpl;
import net.kaikoga.arpx.backends.flash.field.FieldFlashImpl;
#end

@:arpType("field")
class Field implements IArpObject
#if (arp_backend_flash || arp_backend_openfl) implements IFieldFlashImpl #end
{

	@:arpBarrier @:arpField("mortal") public var initMortals:IOmap<String, Mortal>;
	@:arpBarrier @:arpField(false) private var _mortals:IOmap<String, Mortal>;
	@:arpBarrier @:arpField("anchor") public var anchors:IOmap<String, Anchor>;

	public var mortals(default, null):IOmap<String, Mortal>;
	public var gridSize(get, never):Int;
	public var width(get, never):Int;
	public var height(get, never):Int;

	private var hitField:HitObjectField<HitGeneric, HitMortal>;
	private var anchorField:HitField<HitGeneric, Anchor>;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:FieldFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new() {
	}

	@:arpHeatUp private function heatUp():Bool {
		if (this.mortals == null) this.mortals = new MortalMap(this);
		if (this.hitField == null) this.hitField = new HitObjectField<HitGeneric, HitMortal>(new HitWithCuboid());
		if (this.anchorField == null) this.anchorField = new HitField<HitGeneric, Anchor>(new HitWithCuboid());
		this.reinitMortals();
		return true;
	}

	private function get_gridSize():Int {
		return 1;
	}

	private function get_width():Int {
		return 0;
	}

	private function get_height():Int {
		return 0;
	}

	public function addHit(mortal:Mortal, hitType:String, life:Float):HitGeneric {
		return hitField.add(mortal.asHitType(hitType), life);
	}

	public function findHit(mortal:Mortal, hitType:String):HitGeneric {
		return hitField.find(mortal.asHitType(hitType));
	}

	public function addAnchorHit(anchor:Anchor, life:Float):HitGeneric {
		return anchorField.add(anchor, life);
	}

	public function reinitMortals():Void {
		OmapOp.copy(this.initMortals, this.mortals);
	}

	public function tick():Void {
		for (mortal in this.mortals) mortal.tick(this);
		for (anchor in this.anchors) anchor.tick(this);
		this.hitField.tick();
		this.anchorField.tick();
		this.hitField.hitTest(function(a:HitMortal, b:HitMortal):Bool {
			if (a.hitType != b.hitType) return false;
			if (a.isComplex) {
				if (b.isComplex) {
					return false;
				} else {
					if (!a.mortal.complexHitTest(a.hit, b.hit)) return false;
				}
			} else if (b.isComplex) {
				if (!b.mortal.complexHitTest(b.hit, a.hit)) return false;
			}
			a.mortal.collide(this, b.mortal);
			b.mortal.collide(this, a.mortal);
			return false;
		});
	}

	public function bulkHitRaw(srcHitType:String, hitType:String, callback:HitMortal->HitMortal->Bool):Void {
		// TODO seriously use layer
		this.hitField.hitTest(function(a:HitMortal, b:HitMortal):Bool {
			if (a.hitType != srcHitType) return false;
			if (b.hitType != hitType) return false;
			if (a.isComplex) {
				if (b.isComplex) {
					return false;
				} else {
					if (!a.mortal.complexHitTest(a.hit, b.hit)) return false;
				}
			} else if (b.isComplex) {
				if (!b.mortal.complexHitTest(b.hit, a.hit)) return false;
			}
			return callback(a, b);
		});
	}

	public function hitRaw(hit:HitGeneric, hitType:String, callback:HitMortal->Bool):Void {
		this.hitField.hitRaw(hit, function(other:HitMortal):Bool {
			if (other.hitType != hitType) return false;
			if (other.isComplex) {
				if (!other.mortal.complexHitTest(other.hit, hit)) return false;
			}
			return callback(other);
		});
	}

	public function mortalAt(self:Mortal, x:Float, y:Float, z:Float, hitType:String):Mortal {
		var result:Mortal = null;
		this.hitRaw(new HitGeneric().setCuboid(x, y, z, 0, 0, 0), hitType, function(other:HitMortal):Bool {
			if (self != other.mortal) {
				result = other.mortal;
				return true;
			}
			return false;
		});
		return result;
	}

	public function mortalsAt(self:Mortal, x:Float, y:Float, z:Float, hitType:String):Array<Mortal> {
		var result:Array<Mortal> = [];
		this.hitRaw(new HitGeneric().setCuboid(x, y, z, 0, 0, 0), hitType, function(other:HitMortal):Bool {
			if (self != other.mortal) {
				result.push(other.mortal);
			}
			return false;
		});
		return result;
	}

	public function dispatchReactFrame(self:Mortal, reactFrame:ReactFrame, delay:Float):Void {
		this.hitRaw(reactFrame.exportHitGeneric(self.position, new HitGeneric()), reactFrame.hitType, function(other:HitMortal):Bool {
			if (self != other.mortal) {
				other.mortal.react(this, self, reactFrame, delay);
			}
			return false;
		});
	}

	public function anchorAt(x:Float, y:Float, z:Float):Anchor {
		var result:Anchor = null;
		this.anchorField.hitRaw(new HitGeneric().setCuboid(x, y, z, 0, 0, 0), function(other:Anchor):Bool {
			result = other;
			return true;
		});
		return result;
	}

	public function anchorsAt(x:Float, y:Float, z:Float):Array<Anchor> {
		var result:Array<Anchor> = [];
		this.anchorField.hitRaw(new HitGeneric().setCuboid(x, y, z, 0, 0, 0), function(other:Anchor):Bool {
			result.push(other);
			return false;
		});
		return result;
	}
}

@:access(net.kaikoga.arpx.field.Field._mortals)
@:access(net.kaikoga.arpx.mortal.Mortal._field)
class MortalMap extends OmapDecorator<String, Mortal> {

	private var field:Field;

	@:allow(net.kaikoga.arpx.field.Field.heatUp)
	private function new(field:Field) {
		super(field._mortals);
		this.field = field;
	}

	//write
	override public function addPair(k:String, v:Mortal):Void {
		if (v._field != null) v._field._mortals.remove(v);
		v._field = this.field;
		this.omap.addPair(k, v);
	}
	override public function insertPairAt(index:Int, k:String, v:Mortal):Void {
		if (v._field != null) v._field._mortals.remove(v);
		v._field = this.field;
		this.omap.insertPairAt(index, k, v);
	}

	// remove
	override public function remove(v:Mortal):Bool {
		v._field = null;
		return this.omap.remove(v);
	}
	override public function removeKey(k:String):Bool {
		if (!this.omap.hasKey(k)) return false;
		this.omap.get(k)._field = null;
		return this.omap.removeKey(k);
	}
	override public function removeAt(index:Int):Bool {
		if (index < 0 || index >= this.omap.length) return false;
		this.omap.getAt(index)._field = null;
		return this.omap.removeAt(index);
	}
	override public function pop():Null<Mortal> {
		if (this.omap.isEmpty()) return null;
		this.omap.last()._field = null;
		return this.omap.pop();
	}
	override public function shift():Null<Mortal> {
		if (this.omap.isEmpty()) return null;
		this.omap.first()._field = null;
		return this.omap.shift();
	}
	override public function clear():Void {
		for (v in this.omap) v._field = null;
		this.omap.clear();
	}
}
