package arpx.impl.cross.display;

import arpx.impl.cross.geom.Transform;

interface IDisplayContext {
	var width(get, never):Int;
	var height(get, never):Int;
	var clearColor(default, null):UInt;

	var transform(get, never):Transform;

	public function start():Void;
	public function display():Void;

	public function dupTransform():Transform;
	public function popTransform():Void;

	public function fillRect(l:Int, t:Int, w:Int, h:Int, color:UInt):Void;
}
