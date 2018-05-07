package net.kaikoga.arpx.impl.backends.heaps.console;

#if arp_backend_heaps

import h2d.Sprite;
import net.kaikoga.arp.impl.IArpObjectImpl;
import net.kaikoga.arpx.display.DisplayContext;

interface IConsoleHeapsImpl extends IArpObjectImpl {
	function display(sprite:Sprite):Void;
	function render(context:DisplayContext):Void;
}

#end
