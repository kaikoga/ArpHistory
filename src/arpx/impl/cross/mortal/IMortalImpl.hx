package arpx.impl.cross.mortal;

import arp.impl.IArpObjectImpl;
import arpx.impl.cross.display.DisplayContext;

interface IMortalImpl extends IArpObjectImpl {
	function render(context:DisplayContext):Void;
}
