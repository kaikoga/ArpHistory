package arpx.impl.cross.display;

import arpx.impl.cross.geom.Transform;

interface IRenderContext {
	var transform(get, never):Transform;

	public function start():Void;
	public function display():Void;

	public function dupTransform():Transform;
	public function popTransform():Void;

	public function fillRect(l:Int, t:Int, w:Int, h:Int, color:UInt):Void;
}
