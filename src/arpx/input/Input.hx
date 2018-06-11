package arpx.input;

import arp.domain.IArpObject;
import arpx.input.focus.IFocusNode;

#if (arp_backend_flash || arp_backend_openfl)
import arpx.impl.backends.flash.input.IInputFlashImpl;
#elseif arp_backend_heaps
import arpx.impl.backends.heaps.input.IInputHeapsImpl;
#end

@:arpType("input", "null")
class Input implements IArpObject implements IFocusNode<Input>
	#if (arp_backend_flash || arp_backend_openfl) implements IInputFlashImpl
	#elseif arp_backend_heaps implements IInputHeapsImpl
	#end
{
	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:IInputFlashImpl;
	#elseif arp_backend_heaps
	@:arpImpl private var heapsImpl:IInputHeapsImpl;
	#end

	public function new() return;

	public function axis(button:String):InputAxis {
		return new InputAxis();
	}

	public function findFocus(other:Null<Input>):Null<Input> return other;
	public function updateFocus(target:Null<Input>):Void return;
}


