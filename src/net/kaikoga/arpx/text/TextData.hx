package net.kaikoga.arpx.text;

import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("text", "null"))
class TextData implements IArpObject {
	public function new() {
	}

	public function publish(params:Map<String, Dynamic> = null):String {
		return "";
	}
}
