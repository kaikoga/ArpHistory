package net.kaikoga.arpx.backends.flash.chip;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.geom.ITransform;

interface IChipFlashImpl extends IArpObjectImpl {

	function copyChip(bitmapData:BitmapData, transform:ITransform, params:IArpParamsRead = null):Void;

	//function exportChipSprite(params : ArpParams = null) : AChipSprite;

}

#end
