package net.kaikoga.arpx.input;

import net.kaikoga.arp.ds.impl.StdMap;
import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arpx.backends.flash.input.IInputFlashImpl;
import net.kaikoga.arp.domain.IArpObject;

#if arp_backend_flash
import flash.events.IEventDispatcher;
#end

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("input", "null"))
class Input implements IArpObject implements IInputFlashImpl{

	public var inputAxes:IMap<String, InputAxis>;

	#if arp_backend_flash

	private var flashImpl:IInputFlashImpl;

	private function createImpl():IInputFlashImpl return null;

	public function new() {
		this.inputAxes = new StdMap<String, InputAxis>();
		flashImpl = createImpl();
	}

	public function listen(target:IEventDispatcher):Void flashImpl.listen(target);

	public function purge():Void flashImpl.purge();

	public function tick(timeslice:Float):Void {
		flashImpl.tick(timeslice);
		for (axis in this.inputAxes) axis.tick(timeslice);
	}

	#else

	@:arpWithoutBackend
	public function new () {
		this.inputAxes = new StdMap<String, InputAxis>();
	}

	#end

	public function clear():Void {
		this.inputAxes.clear();
	}

	public function axis(button:String):InputAxis {
		if (this.inputAxes.hasKey(button)) {
			return this.inputAxes.get(button);
		}
		var axis:InputAxis = new InputAxis();
		this.inputAxes.set(button, axis);
		return axis;
	}
}


