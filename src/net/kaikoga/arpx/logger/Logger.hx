package net.kaikoga.arpx.logger;

import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("logger", "null"))
class Logger implements IArpObject {

	public function new() {
	}

	public function log(category:String, message:String):Void {
	}

	public function respondsTo(category:String):Bool {
		return category == "*" || this.categories.byName(category) != null || this.categories.byName("*") != null;
	}
}


