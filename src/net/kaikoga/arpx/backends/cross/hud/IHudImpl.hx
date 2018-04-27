package net.kaikoga.arpx.backends.cross.hud;

import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.display.DisplayContext;

interface IHudImpl extends IArpObjectImpl {
	function render(context:DisplayContext):Void;
}
