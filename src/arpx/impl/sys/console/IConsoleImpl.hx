package arpx.impl.sys.console;

#if arp_display_backend_sys

import arp.impl.IArpObjectImpl;
import arpx.impl.cross.display.DisplayContext;

interface IConsoleImpl extends IArpObjectImpl {
	function display():Void;
	function render(context:DisplayContext):Void;
}

#end
