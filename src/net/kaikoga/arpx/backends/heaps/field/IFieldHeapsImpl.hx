package net.kaikoga.arpx.backends.heaps.field;

#if arp_backend_heaps

import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;

interface IFieldHeapsImpl extends IArpObjectImpl {
	function render(context:DisplayContext):Void;
}

#end
