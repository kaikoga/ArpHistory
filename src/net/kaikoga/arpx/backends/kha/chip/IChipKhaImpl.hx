package net.kaikoga.arpx.backends.kha.chip;

#if arp_backend_kha

import kha.graphics2.Graphics;
import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.geom.ITransform;

interface IChipKhaImpl extends IArpObjectImpl {

	function copyChip(g2:Graphics, transform:ITransform, params:IArpParamsRead = null):Void;

}

#end
