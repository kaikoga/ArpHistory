package net.kaikoga.arpx.text;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.structs.ArpParams;

@:arpType("text", "null")
class TextData implements IArpObject {
	public function new() {
	}

	public function publish(params:ArpParams = null):String {
		return "";
	}
}
