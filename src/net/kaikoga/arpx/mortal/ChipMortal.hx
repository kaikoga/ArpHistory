package net.kaikoga.arpx.mortal;

import net.kaikoga.arpx.chip.Chip;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.mortal.ChipMortalFlashImpl;
#elseif arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.mortal.ChipMortalHeapsImpl;
#end

@:arpType("mortal", "chip")
class ChipMortal extends Mortal {

	@:arpBarrier @:arpField public var chip:Chip;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:ChipMortalFlashImpl;
	#elseif arp_backend_heaps
	@:arpImpl private var heapsImpl:ChipMortalHeapsImpl;
	#end

	public function new() super();


	override public function startAction(actionName:String, restart:Bool = false):Bool {
		this.params.set("face", actionName);
		return true;
	}

}


