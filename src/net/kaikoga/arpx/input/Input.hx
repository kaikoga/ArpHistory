package net.kaikoga.arpx.input;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.input.focus.IFocusNode;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.input.IInputFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.input.IInputKhaImpl;
#end

@:arpType("input", "null")
class Input implements IArpObject implements IFocusNode<Input>
	#if (arp_backend_flash || arp_backend_openfl) implements IInputFlashImpl #end
	#if arp_backend_kha implements IInputKhaImpl #end
{
	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:IInputFlashImpl;
	#end

	#if arp_backend_kha
	@:arpImpl private var khaImpl:IInputKhaImpl;
	#end

	public function new() return;

	public function axis(button:String):InputAxis {
		return new InputAxis();
	}

	public function findFocus(other:Null<Input>):Null<Input> return other;
	public function updateFocus(target:Null<Input>):Void return;
}


