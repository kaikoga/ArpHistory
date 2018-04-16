package net.kaikoga.arpx.backends.heaps.hud;

#if arp_backend_heaps

import h2d.Sprite;

import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.backends.heaps.geom.ITransform;

interface IHudHeapsImpl extends IArpObjectImpl {
	function copySelf(buf:Sprite, transform:ITransform):Void;
}

#end
