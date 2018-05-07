package net.kaikoga.arpx.backends.cross.field;

import net.kaikoga.arp.impl.IArpObjectImpl;
import net.kaikoga.arpx.display.DisplayContext;

interface IFieldImpl extends IArpObjectImpl {
	function render(context:DisplayContext):Void;
}

