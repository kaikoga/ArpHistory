package net.kaikoga.arpx.menuItem;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.text.TextData;

@:arpType("menuItem")
class MenuItem implements IArpObject {
	@:arpField public var text:TextData;

	public function new() {
	}
}


