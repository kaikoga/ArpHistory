package net.kaikoga.arpx.field;

import net.kaikoga.arp.hit.fields.HitObjectField;
import net.kaikoga.arp.hit.strategies.HitWithCuboid;
import net.kaikoga.arp.hit.structs.HitGeneric;
import net.kaikoga.arp.hit.fields.HitField;
import net.kaikoga.arp.ds.lambda.OmapOp;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.anchor.Anchor;
import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arpx.mortal.Mortal;
import net.kaikoga.arpx.reactFrame.ReactFrame;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.field.IFieldFlashImpl;
import net.kaikoga.arpx.backends.flash.field.FieldFlashImpl;
#end

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("field"))
class Field implements IArpObject
#if (arp_backend_flash || arp_backend_openfl) implements IFieldFlashImpl #end
{

	@:arpBarrier @:arpField("mortal") public var initMortals:IOmap<String, Mortal>;
	@:arpBarrier @:arpField(false) public var mortals:IOmap<String, Mortal>;
	@:arpBarrier @:arpField("anchor") public var anchors:IOmap<String, Anchor>;

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
	public function new () {
	}

	@:arpHeatUp private function heatUp():Bool {
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