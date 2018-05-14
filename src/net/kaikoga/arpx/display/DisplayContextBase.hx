package net.kaikoga.arpx.display;

import net.kaikoga.arpx.geom.AMatrix;
import net.kaikoga.arpx.geom.ITransform;

class DisplayContextBase {

	public var clearColor(default, null):UInt;

	public var transform(get, never):ITransform;
	private var transforms:Array<ITransform>;

	private function get_transform():ITransform return this.transforms[this.transforms.length - 1];
	public function dupTransform():ITransform {
		var transform:ITransform = this.transform.toCopy();
		this.transforms.push(transform);
		return transform;
	}
	public function pushTransform(transform:ITransform):Void this.transforms.push(transform);
	public function popTransform():ITransform return if (this.transforms.length > 0) this.transforms.pop() else null;

	public function new(transform:ITransform = null, clearColor:UInt = 0xff000000) {
		this.transforms = [(transform == null) ? new AMatrix() : transform];
		this.clearColor = clearColor;
	}
}
