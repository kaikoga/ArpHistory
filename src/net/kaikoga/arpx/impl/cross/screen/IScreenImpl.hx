package net.kaikoga.arpx.impl.cross.screen;

import net.kaikoga.arp.impl.IArpObjectImpl;
import net.kaikoga.arpx.display.DisplayContext;

interface IScreenImpl extends IArpObjectImpl {
	function display(context:DisplayContext):Void;
}