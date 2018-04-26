package net.kaikoga.arpx.driver;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.mortal.Mortal;

@:arpType("driver", "null")
class Driver implements IArpObject {

	public function new() {
	}

	public function tick(field:Field, mortal:Mortal):Void {
	}

	public function startAction(mortal:Mortal, actionName:String, restart:Bool = false):Bool {
		return false;
	}
}


