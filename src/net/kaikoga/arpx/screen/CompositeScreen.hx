package net.kaikoga.arpx.screen;

import net.kaikoga.arpx.input.Input;
import net.kaikoga.arp.ds.IOmap;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.screen.CompositeScreenFlashImpl;
#end

@:arpType("screen", "composite")
class CompositeScreen extends Screen {
	@:arpBarrier @:arpField("screen") public var screens:IOmap<String, Screen>;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:CompositeScreenFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new() super();

	override public function tick(timeslice:Float):Bool {
		for (screen in this.screens) screen.tick(timeslice);
		return true;
	}

	override public function visitFocus(other:Null<Input>):Null<Input> {
		for (screen in this.screens) other = screen.visitFocus(other);
		return other;
	}
}
