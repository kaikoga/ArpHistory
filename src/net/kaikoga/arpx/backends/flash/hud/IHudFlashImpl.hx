package net.kaikoga.arpx.backends.flash.hud;

#if (arp_backend_flash || arp_backend_openfl)

import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.backends.flash.display.DisplayContext;

interface IHudFlashImpl extends IArpObjectImpl {
	function render(context:DisplayContext):Void;
}

#end
