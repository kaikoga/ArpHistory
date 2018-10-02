package arpx.impl.js.input;

#if arp_input_backend_js

import js.html.Element;

import arp.impl.IArpObjectImpl;

interface IInputImpl extends IArpObjectImpl {
	function listen(target:Element):Void;
	function purge():Void;
}

#end
