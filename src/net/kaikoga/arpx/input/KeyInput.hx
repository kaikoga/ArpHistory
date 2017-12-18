package net.kaikoga.arpx.input;

import net.kaikoga.arp.ds.impl.StdMap;
import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arpx.backends.flash.input.KeyInputFlashImpl;

@:arpType("input", "key")
class KeyInput extends PhysicalInput {

	public var keyBindings:IMap<Int, KeyInputBinding>;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:KeyInputFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new() {
		super();
		this.keyBindings = new StdMap<Int, KeyInputBinding>();
	}

	public function bindButton(keyCode:Int, axis:String):Void {
		keyBindings.set(keyCode, new KeyInputBinding(keyCode, axis, 1.0));
	}

	public function bindAxis(keyCode:Int, axis:String, factor:Float):Void {
		keyBindings.set(keyCode, new KeyInputBinding(keyCode, axis, factor));
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


