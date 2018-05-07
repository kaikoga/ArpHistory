package net.kaikoga.arpx.impl.cross.mortal;

import net.kaikoga.arp.impl.IArpObjectImpl;
import net.kaikoga.arpx.display.DisplayContext;

interface IMortalImpl extends IArpObjectImpl {
	function render(context:DisplayContext):Void;
}
