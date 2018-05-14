package net.kaikoga.arpx.display;

import net.kaikoga.arpx.geom.Transform;

class DisplayContextBase {

	public var clearColor(default, null):UInt;

	public var transform(get, never):Transform;
	private var transforms:Array<Transform>;

	private function get_transform():Transform return this.transforms[this.transforms.length - 1];
	public function dupTransform():Transform {
		var transform:Transform = this.transform.toCopy();
		this.transforms.push(transform);
		return transform;
	}
	public function pushTransform(transform:Transform):Void this.transforms.push(transform);
	public function popTransform():Transform return if (this.transforms.length > 0) this.transforms.pop() else null;

	public function new(transform:Transform = null, clearColor:UInt = 0xff000000) {
		this.transforms = [(transform == null) ? new Transform() : transform];
		this.clearColor = clearColor;
	}
}
