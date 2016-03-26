package net.kaikoga.arpx.shadow;

import net.kaikoga.arp.domain.IArpObject;

#if arp_backend_flash
import net.kaikoga.arpx.backends.flash.shadow.IShadowFlashImpl;
#end

interface IShadow extends IArpObject
#if arp_backend_flash extends IShadowFlashImpl #end
{
	// public function frameMove():Void;
}
