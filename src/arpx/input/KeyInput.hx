package arpx.input;

import arp.ds.impl.ArrayList;

#if (arp_input_backend_flash || arp_input_backend_openfl)
import arpx.impl.backends.flash.input.KeyInputFlashImpl;
#elseif arp_input_backend_heaps
import arpx.impl.backends.heaps.input.KeyInputHeapsImpl;
#end

@:arpType("input", "key")
class KeyInput extends PhysicalInput {

	public var keyBindings:ArrayList<KeyInputBinding>;

	#if (arp_input_backend_flash || arp_input_backend_openfl)
	@:arpImpl private var flashImpl:KeyInputFlashImpl;
	#elseif arp_input_backend_heaps
	@:arpImpl private var heapsImpl:KeyInputHeapsImpl;
	#end

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


