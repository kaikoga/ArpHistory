package net.kaikoga.arpx.backends.cross.screen;

import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.display.DisplayContext;

interface IScreenImpl extends IArpObjectImpl {
	function display(context:DisplayContext):Void;
}
