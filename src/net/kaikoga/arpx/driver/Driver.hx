package net.kaikoga.arpx.driver;

import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.mortal.Mortal;
import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("driver", "null"))
class Driver implements IArpObject {

	public function new() {
	}

	public function tick(field:Field, mortal:Mortal):Void {
	}

	public function startAction(mortal:Mortal, actionName:String, restart:Bool = false):Bool {
		return false;
	}
}


