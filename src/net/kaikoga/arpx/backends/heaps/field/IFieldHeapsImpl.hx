package net.kaikoga.arpx.backends.heaps.field;

#if arp_backend_heaps

import h2d.Sprite;

import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.backends.heaps.math.ITransform;

interface IFieldHeapsImpl extends IArpObjectImpl {
	function copySelf(buf:Sprite, transform:ITransform):Void;
}

#end
