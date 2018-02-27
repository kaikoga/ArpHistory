package net.kaikoga.arpx.input;

import net.kaikoga.arp.ds.impl.ArrayList;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.input.KeyInputFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.input.KeyInputKhaImpl;
#end

@:arpType("input", "key")
class KeyInput extends PhysicalInput {

	public var keyBindings:ArrayList<KeyInputBinding>;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:KeyInputFlashImpl;
	#end

	#if arp_backend_kha
	@:arpImpl private var khaImpl:KeyInputKhaImpl;
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


