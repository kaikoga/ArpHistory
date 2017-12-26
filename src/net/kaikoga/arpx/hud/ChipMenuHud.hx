package net.kaikoga.arpx.hud;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.flash.hud.ChipMenuHudFlashImpl;
import net.kaikoga.arpx.chip.Chip;
import net.kaikoga.arpx.input.IInputControl;
import net.kaikoga.arpx.menu.Menu;

@:arpType("hud", "chipMenu")
class ChipMenuHud extends Hud {

	@:arpBarrier @:arpField public var chip:Chip;
	@:arpField public var dPosition:ArpPosition;
	@:arpBarrier @:arpField public var menu:Menu;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:ChipMenuHudFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new() {
		super();
	}

	override public function visitFocus(other:Null<IInputControl>):Null<IInputControl> {
		return this.menu;
	}
}
