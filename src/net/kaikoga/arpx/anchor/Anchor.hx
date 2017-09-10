package net.kaikoga.arpx.anchor;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.hitFrame.HitFrame;

@:arpType("anchor")
class Anchor implements IArpObject {

	@:arpField public var position:ArpPosition;
	@:arpField public var hitFrame:HitFrame;

	public function new() {
	}

	public function refresh(field:Field):Void {
		hitFrame.exportHitGeneric(new ArpPosition(), field.addAnchorHit(this));
	}

}


