package net.kaikoga.arpx.backends.heaps.display;

#if arp_backend_heaps

import h2d.Sprite;
import net.kaikoga.arpx.geom.APoint;
import net.kaikoga.arpx.geom.ITransform;

class DisplayContext {

	public var buf(default, null):Sprite;
	public var width(default, null):Int;
	public var height(default, null):Int;
	public var transform(get, never):ITransform;
	public var transforms:Array<ITransform>;

	public function new(buf:Sprite, width:Int, height:Int, transform:ITransform = null) {
		this.buf = buf;
		this.width = width;
		this.height = height;
		this.transforms = [(transform == null) ? new APoint() : transform];
	}

	public function get_transform():ITransform return this.transforms[this.transforms.length - 1];
	public function pushTransform(transform:ITransform):Void this.transforms.push(transform);
	public function popTransform():ITransform return if (this.transforms.length > 0) this.transforms.pop() else null;
}

#end
