package net.kaikoga.arpx.backends.flash.chip;

import flash.display.BitmapData;
import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.flash.geom.ITransform;

interface IChipFlashImpl extends IArpObjectImpl {

	function copyChip(bitmapData:BitmapData, transform:ITransform, params:IArpParamsRead = null):Void;

	//function exportChipSprite(params : ArpParams = null) : AChipSprite;

}
