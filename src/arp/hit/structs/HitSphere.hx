package arp.hit.structs;

/**
* handled as mutable
*/
class HitSphere {

	public var r:Float = 0;
	public var x:Float = 0;
	public var y:Float = 0;
	public var z:Float = 0;

	public function new() {
	}

	public function setSphere(r:Float, x:Float, y:Float, z:Float):HitSphere {
		this.r = r;
		this.x = x;
		this.y = y;
		this.z = z;
		return this;
	}

	public function toString():String {
		var result:String = "{";
		var bitmap:Int = 0;
		if (r != 0) bitmap |= 0x1;
		if (x != 0) bitmap |= 0x2;
		if (y != 0) bitmap |= 0x4;
		if (z != 0) bitmap |= 0x8;
		if (bitmap & 0xe != 0) {
			if (bitmap & 0x8 == 0) {
				result += '$x,$y';
			} else {
				result += '$x,$y,$z';
			}
		}
		if (bitmap & 0x1 != 0) {
			result += '}*{($r)';
		}
		result += "}";
		return result;
	}
}
