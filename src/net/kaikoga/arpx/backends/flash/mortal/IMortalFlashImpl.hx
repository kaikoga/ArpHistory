package net.kaikoga.arpx.backends.flash.mortal;

#if (arp_backend_flash || arp_backend_openfl)

import net.kaikoga.arpx.backends.flash.display.DisplayContext;
import net.kaikoga.arp.backends.IArpObjectImpl;

interface IMortalFlashImpl extends IArpObjectImpl {
	function render(context:DisplayContext):Void;
}

#end
