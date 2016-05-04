package net.kaikoga.arpx.external;

import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("external", "external"))
class External implements IArpObject {

	public function new() {
	}

	public function load(force:Bool = false):Void {
		//override
	}

	public function unload():Void {
		//override
	}

}
