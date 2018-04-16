package net.kaikoga.arpx.backends.heaps.chip;

#if arp_backend_heaps

import h2d.Sprite;

import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.heaps.geom.ITransform;

interface IChipHeapsImpl extends IArpObjectImpl {

	function copyChip(buf:Sprite, transform:ITransform, params:IArpParamsRead = null):Void;

}

#end
