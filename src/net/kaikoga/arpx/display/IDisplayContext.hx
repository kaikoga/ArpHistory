package net.kaikoga.arpx.display;

import net.kaikoga.arpx.geom.ITransform;

interface IDisplayContext {
	var width(get, never):Int;
	var height(get, never):Int;
	var clearColor(default, null):UInt;

	var transform(get, never):ITransform;

	public function start():Void;
	public function display():Void;

	public function pushTransform(transform:ITransform):Void;
	public function popTransform():ITransform;

	public function fillRect(l:Int, t:Int, w:Int, h:Int, color:UInt):Void;
}
