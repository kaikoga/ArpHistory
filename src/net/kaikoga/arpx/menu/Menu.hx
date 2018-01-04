package net.kaikoga.arpx.menu;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arpx.text.TextData;

@:arpType("menu")
class Menu implements IArpObject {
	@:arpField public var visible:Bool = true;
	@:arpField("text") public var texts:IOmap<String, TextData>;

	@:arpField public var value:Int;

	public var length(get, never):Int;
	inline private function get_length():Int return this.texts.length;

	public function selection():String {
		var t:TextData = this.texts.getAt(this.value);
		return if (t != null) t.publish() else "";
	}

	public function new() {
	}
}


