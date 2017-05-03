﻿package net.kaikoga.arpx.reactFrame;

import net.kaikoga.arp.hit.structs.HitGeneric;
import net.kaikoga.arp.structs.ArpHitCuboid;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("reactFrame"))
class ReactFrame implements IArpObject {

	@:arpField public var time:Float;
	@:arpField public var hitCuboid:ArpHitCuboid;
	@:arpField public var hitType:String;
	@:arpField public var reactType:String;
	@:arpField public var value:String;
	@:arpField public var params:ArpParams;
	@:arpField public var duration:Float;
	@:arpField public var hold:Bool;

	public function new() {
	}

	public function exportHitGeneric(base:ArpPosition, source:HitGeneric):HitGeneric {
		return source.setCuboid(
			base.x + this.hitCuboid.dX,
			base.y + this.hitCuboid.dY,
			base.z + this.hitCuboid.dZ,
			this.hitCuboid.areaLeft,
			this.hitCuboid.areaTop,
			this.hitCuboid.areaHind
		);
	}
}