package arpx.impl.cross.field;

import arp.impl.IArpObjectImpl;
import arpx.display.DisplayContext;

interface IFieldImpl extends IArpObjectImpl {
	function render(context:DisplayContext):Void;
}

