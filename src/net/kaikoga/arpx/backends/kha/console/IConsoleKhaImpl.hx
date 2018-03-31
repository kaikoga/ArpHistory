package net.kaikoga.arpx.backends.kha.console;

#if arp_backend_kha

import kha.graphics2.Graphics;

import net.kaikoga.arp.backends.IArpObjectImpl;

interface IConsoleKhaImpl extends IArpObjectImpl {
	function display(g2:Graphics):Void;
}

#end
