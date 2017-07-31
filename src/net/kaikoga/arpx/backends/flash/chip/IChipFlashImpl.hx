package net.kaikoga.arpx.backends.flash.chip;

import flash.display.BitmapData;
import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.backends.flash.geom.ITransform;

interface IChipFlashImpl extends IArpObjectImpl {

	function copyChip(bitmapData:BitmapData, transform:ITransform, params:ArpParams = null):Void;

	//function exportChipSprite(params : ArpParams = null) : AChipSprite;

}
