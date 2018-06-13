package arpx.impl.cross.display;

import arpx.impl.cross.geom.Transform;

class DisplayContextBase {

	public var clearColor(default, null):UInt;

	public var transform(get, never):Transform;
	private var transforms:Array<Transform>;
	private var transformIndex:Int = 0;

	private function get_transform():Transform return this.transforms[this.transformIndex];
	public function dupTransform():Transform {
		var value:Transform = this.transform;
		var transform:Transform;
		if (++this.transformIndex < this.transforms.length) {
			transform = this.transform.copyFrom(value);
		} else {
			transform = value.clone();
			this.transforms.push(transform);
		}
		return transform;
	}
	public function popTransform():Void if (this.transformIndex > 0) this.transformIndex--;

	public function new(transform:Transform = null, clearColor:UInt = 0xff000000) {
		this.transforms = [new Transform()];
		if (transform != null) this.transform.copyFrom(transform);
		this.clearColor = clearColor;
	}
}
