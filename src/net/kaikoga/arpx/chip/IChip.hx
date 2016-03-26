package net.kaikoga.arpx.chip;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.shadow.IShadow;

#if arp_backend_flash
import net.kaikoga.arpx.backends.flash.chip.IChipFlashImpl;
#end

interface IChip extends IArpObject
#if arp_backend_flash extends IChipFlashImpl #end
{

	var baseX(get, set):Int;
	var baseY(get, set):Int;
	var chipWidth(get, set):Int;
	var chipHeight(get, set):Int;

	function chipWidthOf(params:ArpParams):Int;

	function chipHeightOf(params:ArpParams):Int;

	//TODO hasChipName must distinguish explicit and implicit existence
	function hasFace(face:String):Bool;

	function toShadow(params:ArpParams = null):IShadow;
}
