package net.kaikoga.arpx.backends.cross.chip;

import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.display.DisplayContext;

interface IChipImpl extends IArpObjectImpl {
	function copyChip(context:DisplayContext, params:IArpParamsRead = null):Void;
}
