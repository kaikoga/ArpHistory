package net.kaikoga.arpx.backends.flash.display;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import net.kaikoga.arpx.geom.APoint;
import net.kaikoga.arpx.geom.ITransform;

class DisplayContext {

	public var bitmapData:BitmapData;
	public var transform(get, never):ITransform;
	public var transforms:Array<ITransform>;

	public function new(bitmapData:BitmapData, transform:ITransform = null) {
		this.bitmapData = bitmapData;
		this.transforms = [(transform == null) ? new APoint() : transform];
	}

	public function get_transform():ITransform return this.transforms[this.transforms.length - 1];
	public function pushTransform(transform:ITransform):Void this.transforms.push(transform);
	public function popTransform():ITransform return if (this.transforms.length > 0) this.transforms.pop() else null;
}

#end
