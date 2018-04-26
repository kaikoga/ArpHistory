package net.kaikoga.arpx.backends.kha.mortal;

#if arp_backend_kha

import kha.graphics2.Graphics;
import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.geom.ITransform;

interface IMortalKhaImpl extends IArpObjectImpl {
	function copySelf(g2:Graphics, transform:ITransform):Void;
}

#end