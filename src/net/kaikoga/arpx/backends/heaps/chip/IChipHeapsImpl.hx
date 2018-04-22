package net.kaikoga.arpx.backends.heaps.chip;

#if arp_backend_heaps

import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;

interface IChipHeapsImpl extends IArpObjectImpl {

	function copyChip(context:DisplayContext, params:IArpParamsRead = null):Void;

}

#end
