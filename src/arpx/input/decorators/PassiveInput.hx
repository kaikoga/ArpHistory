package arpx.input.decorators;

#if (arp_backend_flash || arp_backend_openfl)
import arpx.impl.backends.flash.input.decorators.PassiveInputFlashImpl;
#elseif arp_backend_heaps
import arpx.impl.backends.heaps.input.decorators.PassiveInputHeapsImpl;
#end

@:arpType("input", "passive")
class PassiveInput extends Input {

	@:arpField private var input:Input;
	@:arpField public var enabled:Bool = true;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:PassiveInputFlashImpl;
	#elseif arp_backend_heaps
	@:arpImpl private var heapsImpl:PassiveInputHeapsImpl;
	#end

	public function new() super();

	override public function axis(button:String):InputAxis {
		return this.enabled ? this.input.axis(button) : new InputAxis();
	}
}
