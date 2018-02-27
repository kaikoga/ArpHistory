package net.kaikoga.arpx.input.decorators;

import net.kaikoga.arpx.backends.flash.input.decorators.PassiveInputFlashImpl;

@:arpType("input", "passive")
class PassiveInput extends Input {

	@:arpField private var input:Input;
	@:arpField public var enabled:Bool = true;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:PassiveInputFlashImpl;
#end

	public function new() super();

	override public function axis(button:String):InputAxis {
		return this.enabled ? this.input.axis(button) : new InputAxis();
	}
}
