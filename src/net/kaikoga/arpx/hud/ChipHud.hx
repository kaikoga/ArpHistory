package net.kaikoga.arpx.hud;

import net.kaikoga.arpx.chip.Chip;
import net.kaikoga.arpx.impl.cross.hud.ChipHudImpl;

@:arpType("hud", "chip")
class ChipHud extends Hud {

	@:arpBarrier @:arpField public var chip:Chip;

	@:arpImpl private var arpImpl:ChipHudImpl;

	public function new() super();
}


