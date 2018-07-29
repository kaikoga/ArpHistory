package arpx.impl.stub.console;

#if arp_display_backend_stub

import arp.impl.IArpObjectImpl;
import arpx.impl.cross.display.DisplayContext;

interface IConsoleImpl extends IArpObjectImpl {
	function display():Void;
	function render(context:DisplayContext):Void;
}

#end
