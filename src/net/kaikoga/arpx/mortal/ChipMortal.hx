package net.kaikoga.arpx.mortal;

import net.kaikoga.arpx.chip.Chip;
import net.kaikoga.arpx.shadow.ChipShadow;
import net.kaikoga.arpx.shadow.Shadow;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("mortal", "chip"))
class ChipMortal extends Mortal {

	@:arpBarrier @:arpField public var chip:Chip;

	@:arpField public var cachedShadow:ChipShadow;

	public function new() {
		super();
	}

	override public function startAction(actionName:String, restart:Bool = false):Bool {
		this.params.set("face", actionName);
		return true;
	}

	@:access(net.kaikoga.arpx.shadow.ChipShadow)
	override public function toShadow():Shadow {
		var shadow:ChipShadow = this.cachedShadow;
		if (shadow == null) {
			shadow = this.arpDomain().addObject(new ChipShadow());
			this.cachedShadow = shadow;
		}
		shadow.visible = this.visible;
		shadow.params.copyFrom(this.params);
		shadow.position.copyFrom(this.position);
		shadow.chip = this.chip;
		return shadow;
	}
}


