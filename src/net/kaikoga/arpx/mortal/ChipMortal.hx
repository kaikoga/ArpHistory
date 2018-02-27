package net.kaikoga.arpx.mortal;

import net.kaikoga.arpx.chip.Chip;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.mortal.ChipMortalFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.mortal.ChipMortalKhaImpl;
#end

@:arpType("mortal", "chip")
class ChipMortal extends Mortal {

	@:arpBarrier @:arpField public var chip:Chip;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:ChipMortalFlashImpl;
	#end

	#if arp_backend_kha
	@:arpImpl private var khaImpl:ChipMortalKhaImpl;
	#end

	public function new() super();


	override public function startAction(actionName:String, restart:Bool = false):Bool {
		this.params.set("face", actionName);
		return true;
	}

}


