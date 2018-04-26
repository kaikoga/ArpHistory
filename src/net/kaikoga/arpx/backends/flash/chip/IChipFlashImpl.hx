package net.kaikoga.arpx.backends.flash.chip;

#if (arp_backend_flash || arp_backend_openfl)

import net.kaikoga.arpx.backends.flash.display.DisplayContext;
import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arp.structs.IArpParamsRead;

interface IChipFlashImpl extends IArpObjectImpl {

	function copyChip(context:DisplayContext, params:IArpParamsRead = null):Void;

	//function exportChipSprite(params : ArpParams = null) : AChipSprite;

}

#end
