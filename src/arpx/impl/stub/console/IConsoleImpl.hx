package arpx.impl.stub.console;

#if arp_display_backend_stub

import arp.impl.IArpObjectImpl;

interface IConsoleImpl extends IArpObjectImpl {
	function display():Void;
}

#end
