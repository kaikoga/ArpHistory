package arpx.impl.heaps.console;

#if arp_display_backend_heaps

import h2d.Sprite;
import arp.impl.IArpObjectImpl;
import arpx.impl.cross.display.DisplayContext;

interface IConsoleImpl extends IArpObjectImpl {
	function display(sprite:Sprite):Void;
	function render(context:DisplayContext):Void;
}

#end
