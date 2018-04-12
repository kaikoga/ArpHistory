package net.kaikoga.arpx.backends.heaps.screen;

#if arp_backend_heaps

import h2d.Sprite;

import net.kaikoga.arp.backends.IArpObjectImpl;

interface IScreenHeapsImpl extends IArpObjectImpl {
	function display(buf:Sprite):Void;
}

#end
