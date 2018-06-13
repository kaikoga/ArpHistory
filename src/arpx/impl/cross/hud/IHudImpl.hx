package arpx.impl.cross.hud;

import arp.impl.IArpObjectImpl;
import arpx.impl.cross.display.DisplayContext;

interface IHudImpl extends IArpObjectImpl {
	function render(context:DisplayContext):Void;
}
