package net.kaikoga.arpx.console;

import net.kaikoga.arp.domain.IArpObject;

#if arp_backend_flash
import net.kaikoga.arpx.backends.flash.console.IConsoleFlashImpl;
#end

interface IConsole extends IArpObject
#if arp_backend_flash extends IConsoleFlashImpl #end
{
}
