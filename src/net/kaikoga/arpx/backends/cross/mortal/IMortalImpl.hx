package net.kaikoga.arpx.backends.cross.mortal;

import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.display.DisplayContext;

interface IMortalImpl extends IArpObjectImpl {
	function render(context:DisplayContext):Void;
}
