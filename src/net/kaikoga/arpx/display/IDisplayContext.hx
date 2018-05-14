package net.kaikoga.arpx.display;

import net.kaikoga.arpx.geom.Transform;

interface IDisplayContext {
	var width(get, never):Int;
	var height(get, never):Int;
	var clearColor(default, null):UInt;

	var transform(get, never):Transform;

	public function start():Void;
	public function display():Void;

	public function pushTransform(transform:Transform):Void;
	public function popTransform():Transform;

	public function fillRect(l:Int, t:Int, w:Int, h:Int, color:UInt):Void;
}
