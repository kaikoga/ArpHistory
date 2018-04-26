package net.kaikoga.arpx.backends.flash.screen;

#if (arp_backend_flash || arp_backend_openfl)

import net.kaikoga.arpx.backends.flash.display.DisplayContext;
import net.kaikoga.arp.backends.IArpObjectImpl;

interface IScreenFlashImpl extends IArpObjectImpl {
	function display(context:DisplayContext):Void;
}

#end
