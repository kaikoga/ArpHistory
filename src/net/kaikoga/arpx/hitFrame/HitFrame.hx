package net.kaikoga.arpx.hitFrame;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.hit.structs.HitGeneric;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.mortal.Mortal;
import net.kaikoga.arpx.structs.ArpPosition;

@:arpType("hitFrame", "null")
class HitFrame implements IArpObject {

	@:arpField public var hitType:String;

	public function new() {
	}

	public function exportHitGeneric(base:ArpPosition, source:HitGeneric):HitGeneric {
		return source;
	}

	public function updateHitMortal(field:Field, mortal:Mortal):Void {
		this.exportHitGeneric(mortal.position, field.addHit(mortal, this.hitType));
	}

	public function mapTo(base:ArpPosition, targetBase:ArpPosition, target:HitFrame, input:ArpPosition, output:ArpPosition = null):ArpPosition {
		if (output != null) return output;
		return input.clone();
	}
}


