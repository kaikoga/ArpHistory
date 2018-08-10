package arpx.impl.sys.console;

#if arp_display_backend_sys

import arp.impl.IArpObjectImpl;

interface IConsoleImpl extends IArpObjectImpl {
	function display():Void;
}

#end
