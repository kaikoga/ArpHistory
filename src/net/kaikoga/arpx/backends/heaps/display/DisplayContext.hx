package net.kaikoga.arpx.backends.heaps.display;

#if arp_backend_heaps

import h2d.Sprite;
import net.kaikoga.arpx.display.DisplayContextBase;
import net.kaikoga.arpx.display.IDisplayContext;
import net.kaikoga.arpx.geom.ITransform;

class DisplayContext extends DisplayContextBase implements IDisplayContext {

	public var buf(default, null):Sprite;
	public var width(default, null):Int;
	public var height(default, null):Int;

	public function new(buf:Sprite, width:Int, height:Int, transform:ITransform = null, clearColor:UInt = 0) {
		super(transform, clearColor);
		this.buf = buf;
		this.width = width;
		this.height = height;
	}

	public function start():Void this.buf.removeChildren();
	public function display():Void return;
}

#end
