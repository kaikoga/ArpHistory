package arpx.impl.cross.chip;

import arp.impl.IArpObjectImpl;
import arpx.impl.cross.display.DisplayContext;
import arpx.structs.IArpParamsRead;

interface IChipImpl extends IArpObjectImpl {
	function render(context:DisplayContext, params:IArpParamsRead = null):Void;
}
