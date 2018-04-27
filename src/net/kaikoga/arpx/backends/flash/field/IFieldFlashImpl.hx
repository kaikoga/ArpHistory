package net.kaikoga.arpx.backends.flash.field;

#if (arp_backend_flash || arp_backend_openfl)

import net.kaikoga.arpx.backends.flash.display.DisplayContext;
import net.kaikoga.arp.backends.IArpObjectImpl;

interface IFieldFlashImpl extends IArpObjectImpl {
	function copySelf(context:DisplayContext):Void;
}

#end
