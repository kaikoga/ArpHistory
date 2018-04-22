package net.kaikoga.arpx.backends.heaps.mortal;

#if arp_backend_heaps

import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;

interface IMortalHeapsImpl extends IArpObjectImpl {
	function copySelf(context:DisplayContext):Void;
}

#end
