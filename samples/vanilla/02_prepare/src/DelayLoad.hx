package;

import haxe.Timer;
import arp.domain.IArpObject;

@:arpType("delay", "delay")
class DelayLoad implements IArpObject {

	@:arpField public var delayMs:Int;

	private var heat:Int = 0;

	public function new() {
	}

	@:arpHeatUp
	private function heatUp():Bool {
		#if flash
		if (this.heat == 0) {
			this.arpDomain.waitFor(this);
			Timer.delay(function():Void {
				this.arpDomain.notifyFor(this);
				this.heat = 2;
			}, this.delayMs);
			this.heat = 1;
		}
		return this.heat == 2;
		#else
		return true;
		#end
	}

	@:arpHeatDown
	private function heatDown():Bool {
		return true;
	}

}
