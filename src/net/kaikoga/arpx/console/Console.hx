package net.kaikoga.arpx.console;

import net.kaikoga.arpx.input.focus.IFocusNode;
import net.kaikoga.arpx.input.Input;
import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.task.ITickable;
import net.kaikoga.arpx.screen.Screen;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.console.ConsoleFlashImpl;
import net.kaikoga.arpx.backends.flash.console.IConsoleFlashImpl;
#end

@:arpType("console", "console")
class Console implements IArpObject implements ITickable implements IFocusNode<Input>
#if (arp_backend_flash || arp_backend_openfl) implements IConsoleFlashImpl #end
{
	@:arpField public var width:Int;
	@:arpField public var height:Int;

	@:arpField("screen") public var screens:IOmap<String, Screen>;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:ConsoleFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new() {
	}

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
