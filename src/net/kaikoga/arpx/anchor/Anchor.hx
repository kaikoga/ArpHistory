package net.kaikoga.arpx.anchor;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.hitFrame.HitFrame;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.mortal.Mortal;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("anchor"))
class Anchor implements IArpObject {

	@:arpField public var position:ArpPosition;
	@:arpField public var hitFrame:HitFrame;

	public function new() {
	}

	public function collidesPosition(position:ArpPosition):Bool {
		var hitFrame:HitFrame = this.hitFrame;
		return (hitFrame != null) ? hitFrame.collidesPosition(this.position, position) : false;
	}

	public function collidesCoordinate(x:Float, y:Float, z:Float):Bool {
		var hitFrame:HitFrame = this.hitFrame;
		return (hitFrame != null) ? hitFrame.collidesCoordinate(this.position, x, y, z) : false;
	}

	public function collidesMortal(mortal:Mortal, hitType:String):Bool {
		var hitFrame:HitFrame = this.hitFrame;
		return (hitFrame != null) ? hitFrame.collidesHitFrame(this.position, mortal.position, mortal.hitFrames.get(hitType)) : false;
	}
}


