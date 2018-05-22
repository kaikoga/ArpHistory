package net.kaikoga.arpx.impl.cross.chip;

import net.kaikoga.arp.impl.IArpObjectImpl;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.structs.IArpParamsRead;

interface IChipImpl extends IArpObjectImpl {
	function render(context:DisplayContext, params:IArpParamsRead = null):Void;
}
