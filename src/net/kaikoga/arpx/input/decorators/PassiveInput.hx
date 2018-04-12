package net.kaikoga.arpx.input.decorators;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.input.decorators.PassiveInputFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.input.decorators.PassiveInputKhaImpl;
#end

#if arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.input.decorators.PassiveInputHeapsImpl;
#end

@:arpType("input", "passive")
class PassiveInput extends Input {

	@:arpField private var input:Input;
	@:arpField public var enabled:Bool = true;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:PassiveInputFlashImpl;
	#end

	#if arp_backend_kha
	@:arpImpl private var khaImpl:PassiveInputKhaImpl;
	#end

	#if arp_backend_heaps
	@:arpImpl private var heapsImpl:PassiveInputHeapsImpl;
	#end

	public function new() super();

	override public function axis(button:String):InputAxis {
		return this.enabled ? this.input.axis(button) : new InputAxis();
	}
}
