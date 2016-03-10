package net.kaikoga.arpx.console;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.backends.flash.console.IConsoleFlashImpl;

interface IConsole extends IArpObject
#if arp_backend_flash extends IConsoleFlashImpl #end
{
}
