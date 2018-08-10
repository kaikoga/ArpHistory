package arpx.impl.heaps.console;

#if arp_display_backend_heaps

import h2d.Sprite;
import arp.impl.IArpObjectImpl;

interface IConsoleImpl extends IArpObjectImpl {
	function display(sprite:Sprite):Void;
}

#end
