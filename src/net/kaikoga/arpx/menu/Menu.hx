package net.kaikoga.arpx.menu;

import net.kaikoga.arpx.input.InputAxis;
import net.kaikoga.arpx.input.Input;
import net.kaikoga.arpx.input.IInputControl;
import net.kaikoga.arpx.text.TextData;
import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arp.domain.IArpObject;

@:arpType("menu")
class Menu implements IArpObject implements IInputControl {
	@:arpField public var visible:Bool = true;
	@:arpField public var axis:String = "y"; // FIXME
	@:arpField("text") public var texts:IOmap<String, TextData>;

	public function new() {
	}

	@:arpField public var value:Int;
	public function selection():String {
		var t:TextData = this.texts.getAt(this.value);
		return if (t != null) t.publish() else "";
	}

	public function visitFocus(other:Null<IInputControl>):Null<IInputControl> return this;
	public function setFocus(value:Bool):Void return;

	public function interact(input:Input):Bool {
		var axis:InputAxis = input.axis(this.axis);
		if (axis.isTrigger) {
			if (axis.value > 0) {
				if (++this.value >= this.texts.length) this.value--;
			} else if (axis.value < 0) {
				if (--this.value < 0) this.value++;
			}
		}
		return true;
	}
}


