package net.kaikoga.arpx.impl.cross.chip;

import net.kaikoga.arp.impl.IArpObjectImpl;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.display.DisplayContext;

interface IChipImpl extends IArpObjectImpl {
	function render(context:DisplayContext, params:IArpParamsRead = null):Void;
}
