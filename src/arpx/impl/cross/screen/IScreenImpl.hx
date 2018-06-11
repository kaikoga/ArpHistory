package arpx.impl.cross.screen;

import arp.impl.IArpObjectImpl;
import arpx.display.DisplayContext;

interface IScreenImpl extends IArpObjectImpl {
	function display(context:DisplayContext):Void;
}
