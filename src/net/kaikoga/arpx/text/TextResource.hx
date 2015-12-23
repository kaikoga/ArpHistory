package net.kaikoga.arpx.text;

import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("text"))
class TextResource implements ITextResource implements IArpObject {

	@:arpValue public var value:String = null;

	public function new() {
	}

	public function publish(params:Map<String, Dynamic> = null):String {
		return this.value;
	}
}


