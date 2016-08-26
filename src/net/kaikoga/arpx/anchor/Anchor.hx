package net.kaikoga.arpx.anchor;

import net.kaikoga.arpx.field.Field;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.hitFrame.HitFrame;
import net.kaikoga.arp.structs.ArpPosition;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("anchor"))
class Anchor implements IArpObject {

	@:arpField public var position:ArpPosition;
	@:arpField public var hitFrame:HitFrame;

	public function new() {
	}

	public function tick(field:Field):Void {
		hitFrame.exportHitGeneric(new ArpPosition(), field.addAnchorHit(this, 2.0));
	}

}


