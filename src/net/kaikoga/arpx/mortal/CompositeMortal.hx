package net.kaikoga.arpx.mortal;

import net.kaikoga.arpx.reactFrame.ReactFrame;
import net.kaikoga.arp.ds.IList;
import net.kaikoga.arpx.mortal.Mortal;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.shadow.CompositeShadow;
import net.kaikoga.arpx.shadow.Shadow;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("mortal", "composite"))
class CompositeMortal extends Mortal {

	@:arpField public var sort:String;
	@:arpField("mortal") @:arpBarrier public var mortals:IList<Mortal>;
	@:arpField public var cachedShadow:CompositeShadow;

	public function new() {
		super();
	}

	override public function tick(field:Field):Void {
		super.tick(field);
		for (mortal in this.mortals) {
			mortal.tick(field);
		}
	}

	override public function startAction(actionName:String, restart:Bool = false):Bool {
		var result:Bool = false;
		for (mortal in this.mortals) {
			result = mortal.startAction(actionName, restart) || result;
		}
		return result;
	}

	override public function react(field:Field, source:Mortal, reactFrame:ReactFrame, delay:Float):Void {
		for (mortal in this.mortals) {
			mortal.react(field, source, reactFrame, delay);
		}
	}

	@:access(net.kaikoga.arpx.shadow.CompositeShadow)
	override public function toShadow():Shadow {
		var shadow:CompositeShadow = this.cachedShadow;
		if (shadow == null) {
			shadow = this.arpDomain().addObject(new CompositeShadow());
			this.cachedShadow = shadow;
		}
		shadow.shadows.clear();
		for (mortal in this.mortals) {
			var mortalShadow:Shadow = mortal.toShadow();
			if (mortalShadow != null) {
				shadow.shadows.add(mortalShadow);
			}
		}
		shadow.visible = this.visible;
		shadow.position.copyFrom(this.position);
		return shadow;
	}

	override private function get_params():ArpParams {
		return new ArpParams();
	}

	override private function set_params(value:ArpParams):ArpParams {
		for (mortal in this.mortals) {
			mortal.params.copyFrom(value);
		}
		return value;
	}
}


