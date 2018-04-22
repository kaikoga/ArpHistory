package net.kaikoga.arpx.backends.heaps.screen;

#if arp_backend_heaps

import net.kaikoga.arpx.backends.heaps.display.DisplayContext;

import net.kaikoga.arp.backends.IArpObjectImpl;

interface IScreenHeapsImpl extends IArpObjectImpl {
	function display(context:DisplayContext):Void;
}

#end
