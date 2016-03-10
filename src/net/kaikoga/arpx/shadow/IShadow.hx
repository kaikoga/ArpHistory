package net.kaikoga.arpx.shadow;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.backends.flash.shadow.IShadowFlashImpl;

interface IShadow extends IArpObject
#if arp_backend_flash extends IShadowFlashImpl #end
{
	// public function frameMove():Void;
}
