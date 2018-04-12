package net.kaikoga.arpx.screen;

import net.kaikoga.arpx.input.focus.IFocusNode;
import net.kaikoga.arpx.input.Input;
import net.kaikoga.arp.task.ITickable;
import net.kaikoga.arp.domain.IArpObject;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.screen.IScreenFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.screen.IScreenKhaImpl;
#end

#if arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.screen.IScreenHeapsImpl;
#end

@:arpType("screen", "null")
class Screen implements IArpObject implements ITickable implements IFocusNode<Input>
#if (arp_backend_flash || arp_backend_openfl) implements IScreenFlashImpl #end
#if arp_backend_kha implements IScreenKhaImpl #end
#if arp_backend_heaps implements IScreenHeapsImpl #end
{
	@:arpField public var ticks:Bool = false;
	@:arpField public var visible:Bool = true;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:IScreenFlashImpl;
	#end

	#if arp_backend_kha
	@:arpImpl private var khaImpl:IScreenKhaImpl;
	#end

	#if arp_backend_heaps
	@:arpImpl private var heapsImpl:IScreenHeapsImpl;
	#end

	public function new() return;

	public function tick(timeslice:Float):Bool {
		return true;
	}

	public function findFocus(other:Null<Input>):Null<Input> {
		return null;
	}

	public function updateFocus(target:Null<Input>):Void {
	}
}
