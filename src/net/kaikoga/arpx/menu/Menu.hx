package net.kaikoga.arpx.menu;

import net.kaikoga.arpx.input.Input;
import net.kaikoga.arpx.input.IInputControl;
import net.kaikoga.arpx.text.TextData;
import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arp.domain.IArpObject;

@:arpType("menu")
class Menu implements IArpObject implements IInputControl {
	@:arpField public var visible:Bool = true;
	@:arpField("text") public var texts:IOmap<String, TextData>;

	public function new() {
	}

	public var value(get, set):Int;
	private function get_value():Int return 0;
	private function set_value(value:Int):Int return value;

	public function selection():String return "";

	public function visitFocus(other:Null<IInputControl>):Null<IInputControl> return this;
	public function setFocus(value:Bool):Void return;

	public function interact(input:Input):Bool {
		this.value = (this.value + 1) & 4;
		return true;
	}
}


