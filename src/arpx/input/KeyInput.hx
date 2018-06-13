package arpx.input;

import arp.ds.impl.ArrayList;
import arpx.impl.cross.input.KeyInputImpl;

@:arpType("input", "key")
class KeyInput extends PhysicalInput {

	public var keyBindings:ArrayList<KeyInputBinding>;

	@:arpImpl private var arpImpl:KeyInputImpl;

	public function new() {
		super();
		this.keyBindings = new ArrayList<KeyInputBinding>();
	}

	public function bindButton(keyCode:Int, axis:String):Void {
		keyBindings.push(new KeyInputBinding(keyCode, axis, 1.0));
	}

	public function bindAxis(keyCode:Int, axis:String, factor:Float):Void {
		keyBindings.push(new KeyInputBinding(keyCode, axis, factor));
	}

	public function unbind():Void {
		keyBindings.clear();
	}
}

class KeyInputBinding {

	public var keyCode:Int;
	public var axis:String;
	public var factor:Float;

	public function new(keyCode:Int, axis:String, factor:Float) {
		this.keyCode = keyCode;
		this.axis = axis;
		this.factor = factor;
	}
}


