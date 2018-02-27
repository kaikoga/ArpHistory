package net.kaikoga.arpx.input;

import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arp.ds.impl.StdMap;

@:arpType("input", "physical")
class PhysicalInput extends Input
{
	public var inputAxes:IMap<String, InputAxis>;

	public function new () {
		super();
		this.inputAxes = new StdMap<String, InputAxis>();
	}

	public function clear():Void {
		this.inputAxes.clear();
	}

	override public function axis(button:String):InputAxis {
		if (this.inputAxes.hasKey(button)) {
			return this.inputAxes.get(button);
		}
		var axis:InputAxis = new InputAxis();
		this.inputAxes.set(button, axis);
		return axis;
	}
}


