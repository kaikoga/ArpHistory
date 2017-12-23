package net.kaikoga.arpx.menu;

import net.kaikoga.arpx.text.TextData;
import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arp.domain.IArpObject;

@:arpType("menu")
class Menu implements IArpObject {
	@:arpField public var visible:Bool = true;
	@:arpField("text") public var texts:IOmap<String, TextData>;

	public function new() {
	}

	public var value(get, set):Int;
	private function get_value():Int return 0;
	private function set_value(value:Int):Int return value;

	public function selection():String return "";

	public function visitFocus(other:Null<Menu>):Null<Menu> return other;
	public function setFocus():Void return;
}


