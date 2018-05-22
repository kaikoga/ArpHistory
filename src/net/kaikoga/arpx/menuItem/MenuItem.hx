package net.kaikoga.arpx.menuItem;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.proc.Proc;
import net.kaikoga.arpx.text.TextData;

@:arpType("menuItem")
class MenuItem implements IArpObject {
	@:arpField public var text:TextData;
	@:arpField public var proc:Proc;

	public function new() {
	}
}


