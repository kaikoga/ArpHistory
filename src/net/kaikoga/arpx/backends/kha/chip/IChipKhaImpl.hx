package net.kaikoga.arpx.backends.kha.chip;

#if arp_backend_kha

import flash.display.BitmapData;
import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.kha.math.ITransform;

interface IChipKhaImpl extends IArpObjectImpl {

	function copyChip(bitmapData:BitmapData, transform:ITransform, params:IArpParamsRead = null):Void;

	//function exportChipSprite(params : ArpParams = null) : AChipSprite;

}

#end
