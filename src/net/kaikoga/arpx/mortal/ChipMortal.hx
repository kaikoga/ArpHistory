package net.kaikoga.arpx.mortal;

#if arp_backend_flash
import net.kaikoga.arpx.backends.flash.mortal.ChipMortalFlashImpl;
import net.kaikoga.arpx.backends.flash.mortal.IMortalFlashImpl;
#end

import net.kaikoga.arpx.chip.Chip;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("mortal", "chip"))
class ChipMortal extends Mortal {

	@:arpBarrier @:arpField public var chip:Chip;

	#if arp_backend_flash

	override private function createImpl():IMortalFlashImpl return new ChipMortalFlashImpl(this);

	public function new () {
		super();
	}

	#else

	@:arpWithoutBackend
	public function new () {
		super();
	}

	#end

	override public function startAction(actionName:String, restart:Bool = false):Bool {
		this.params.set("face", actionName);
		return true;
	}

}


