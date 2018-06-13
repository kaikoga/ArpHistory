package arpx.impl.cross.field;

import arp.impl.IArpObjectImpl;
import arpx.impl.cross.display.DisplayContext;

interface IFieldImpl extends IArpObjectImpl {
	function render(context:DisplayContext):Void;
}

