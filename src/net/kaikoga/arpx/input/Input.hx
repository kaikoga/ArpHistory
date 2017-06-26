package net.kaikoga.arpx.input;

import net.kaikoga.arp.ds.impl.StdMap;
import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arpx.backends.flash.input.IInputFlashImpl;
import net.kaikoga.arp.domain.IArpObject;

@:arpType("input", "null")
class Input implements IArpObject
#if (arp_backend_flash || arp_backend_openfl) implements IInputFlashImpl #end
{

	public var inputAxes:IMap<String, InputAxis>;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:IInputFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new () {
		this.inputAxes = new StdMap<String, InputAxis>();
	}

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


