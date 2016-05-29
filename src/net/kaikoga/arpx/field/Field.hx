package net.kaikoga.arpx.field;

import net.kaikoga.arp.ds.lambda.OmapOp;
import net.kaikoga.arpx.shadow.CompositeShadow;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.anchor.Anchor;
import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arpx.mortal.Mortal;
import net.kaikoga.arpx.reactFrame.ReactFrame;
import net.kaikoga.arpx.shadow.Shadow;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("field"))
class Field implements IArpObject {

	@:arpField("mortal") public var initMortals:IOmap<String, Mortal>;
	@:arpField(false) public var mortals:IOmap<String, Mortal>;
	@:arpField(false) public var cachedShadow:CompositeShadow;
	@:arpField("anchor") public var anchors:IOmap<String, Anchor>;

	public var gridSize(get, never):Int;
	public var width(get, never):Int;
	public var height(get, never):Int;

	@:arpHeatUp private function heatUp():Bool {
		this.reinitMortals();
		return true;
	}

	public function new() {
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

	public function reinitMortals():Void {
		OmapOp.copy(this.initMortals, this.mortals);
	}

	public function tick():Void {
		for (mortal in this.mortals) mortal.tick(this);
	}

	public function objectAt(self:Mortal, x:Float, y:Float, z:Float, hitType:String):Dynamic {
		return this.mortalAt(self, x, y, z, hitType);
	}

	public function mortalAt(self:Mortal, x:Float, y:Float, z:Float, hitType:String):Mortal {
		for (mortal in this.mortals) {
			if ((mortal != self) && mortal.collidesCoordinate(x, y, z, hitType)) {
				return mortal;
			}
		}
		return null;
	}

	public function mortalsAt(self:Mortal, x:Float, y:Float, z:Float, hitType:String):Array<Dynamic> {
		var result:Array<Dynamic> = [];
		for (mortal in this.mortals) {
			if ((mortal != self) && mortal.collidesCoordinate(x, y, z, hitType)) {
				result.push(mortal);
			}
		}
		return result;
	}

	public function dispatchReactFrame(self:Mortal, reactFrame:ReactFrame, delay:Float):Void {
		for (mortal in this.mortals) {
			if ((mortal != self) && reactFrame.collidesMortal(self.position, mortal)) {
				mortal.react(this, self, reactFrame, delay);
			}
		}
	}

	public function anchorAt(x:Float, y:Float, z:Float):Anchor {
		for (anchor in this.anchors) {
			if (anchor.collidesCoordinate(x, y, z)) {
				return anchor;
			}
		}
		return null;
	}

	public function anchorsAt(x:Float, y:Float, z:Float):Array<Dynamic> {
		var result:Array<Dynamic> = [];
		for (anchor in this.anchors) {
			if (anchor.collidesCoordinate(x, y, z)) {
				result.push(anchor);
			}
		}
		return result;
	}

	public function toShadow():Shadow {
		var shadow:CompositeShadow;
		if (this.cachedShadow == null) {
			shadow = new CompositeShadow();
			this.arpDomain().addObject(shadow);
			this.cachedShadow = shadow;
		} else {
			shadow = cast(this.cachedShadow, CompositeShadow);
		}
		this.cachedShadow.shadows.clear();
		for (mortal in this.mortals) {
			var mortalShadow:Shadow = mortal.toShadow();
			if (mortalShadow != null) {
				this.cachedShadow.shadows.add(mortalShadow);
			}
		}
		return shadow;
	}
}


