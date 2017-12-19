package net.kaikoga.arpx.input;

import net.kaikoga.arpx.backends.flash.input.IInputFlashImpl;
import net.kaikoga.arp.domain.IArpObject;

@:arpType("input", "null")
class Input implements IArpObject
#if (arp_backend_flash || arp_backend_openfl) implements IInputFlashImpl #end
{
#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:IInputFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new () {
	}

	public function axis(button:String):InputAxis {
		return new InputAxis();
	}

	public function visitFocus(other:Null<Input>):Null<Input> return other;
	public function setFocus():Void return;
}


