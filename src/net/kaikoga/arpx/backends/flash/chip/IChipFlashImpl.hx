package net.kaikoga.arpx.backends.flash.chip;

import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import flash.display.BitmapData;
import net.kaikoga.arp.structs.ArpParams;

interface IChipFlashImpl extends IArpObjectImpl {

	function copyChip(bitmapData : BitmapData, transform : ITransform, params : ArpParams = null) : Void;

	//function exportChipSprite(params : ArpParams = null) : AChipSprite;

}
