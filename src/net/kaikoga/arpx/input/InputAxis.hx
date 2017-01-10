package net.kaikoga.arpx.input;

class InputAxis {

	public var state(default, null):Bool = false;
	public var value(default, null):Float = 0;
	public var nextValue(default, default):Float = 0;
	public var duration(default, null):Float = 0;
	public var threshold(default, default):Float = 0.5;

	public var isUp(get, null):Bool;
	inline private function get_isUp():Bool return !this.state;

	public var isDown(get, null):Bool;
	inline private function get_isDown():Bool return this.state;

	public var isTriggerUp(get, null):Bool;
	inline private function get_isTriggerUp():Bool return !this.state && this.duration == 0;

	public var isTriggerDown(get, null):Bool;
	inline private function get_isTriggerDown():Bool return this.state && this.duration == 0;

	public function new() {
	}

	public function set_nextValue(value:Float):Float {
		nextValue = value;
		return value;
	}

	public function tick(timeslice:Float):Void {
		var newState:Bool = this.nextValue >= threshold || this.nextValue <= -threshold;
		if (this.state != newState) {
			this.duration = 0;
			this.state = newState;
		} else {
			this.duration += timeslice;
		}
		this.value = this.nextValue;
		this.nextValue = 0;
	}
}
