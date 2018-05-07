package net.kaikoga.arpx.console;

import net.kaikoga.arpx.input.focus.IFocusNode;
import net.kaikoga.arpx.input.Input;
import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.task.ITickable;
import net.kaikoga.arpx.screen.Screen;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.impl.backends.flash.console.ConsoleFlashImpl;
import net.kaikoga.arpx.impl.backends.flash.console.IConsoleFlashImpl;
#end

#if arp_backend_heaps
import net.kaikoga.arpx.impl.backends.heaps.console.ConsoleHeapsImpl;
import net.kaikoga.arpx.impl.backends.heaps.console.IConsoleHeapsImpl;
#end

@:arpType("console", "console")
class Console implements IArpObject implements ITickable implements IFocusNode<Input>
	#if (arp_backend_flash || arp_backend_openfl) implements IConsoleFlashImpl #end
	#if arp_backend_heaps implements IConsoleHeapsImpl #end
{
	@:arpField public var width:Int;
	@:arpField public var height:Int;

	@:arpField("screen") public var screens:IOmap<String, Screen>;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:ConsoleFlashImpl;
	#end

	#if arp_backend_heaps
	@:arpImpl private var heapsImpl:ConsoleHeapsImpl;
	#end

	public function new() return;

	public function tick(timeslice:Float):Bool {
		for (screen in this.screens) screen.tick(timeslice);
		this.updateFocus(this.findFocus(null));
		return true;
	}

	public function findFocus(other:Null<Input>):Null<Input> {
		for (screen in this.screens) other = screen.findFocus(other);
		return other;
	}

	public function updateFocus(target:Null<Input>):Void {
		for (screen in this.screens) screen.updateFocus(target);
	}
}
