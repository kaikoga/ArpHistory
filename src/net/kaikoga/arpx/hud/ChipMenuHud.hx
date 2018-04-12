package net.kaikoga.arpx.hud;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.chip.Chip;
import net.kaikoga.arpx.input.Input;
import net.kaikoga.arpx.input.InputAxis;
import net.kaikoga.arpx.menu.Menu;
import net.kaikoga.arpx.proc.Proc;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.hud.ChipMenuHudFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.hud.ChipMenuHudKhaImpl;
#end

#if arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.hud.ChipMenuHudHeapsImpl;
#end

@:arpType("hud", "chipMenu")
class ChipMenuHud extends Hud {

	@:arpBarrier @:arpField public var chip:Chip;
	@:arpField public var dPosition:ArpPosition;
	@:arpField public var axis:String = "y";
	@:arpField public var execute:String = "s";
	@:arpBarrier @:arpField public var menu:Menu;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:ChipMenuHudFlashImpl;
	#end

	#if arp_backend_kha
	@:arpImpl private var khaImpl:ChipMenuHudKhaImpl;
	#end

	#if arp_backend_heaps
	@:arpImpl private var heapsImpl:ChipMenuHudHeapsImpl;
	#end

	public function new() {
		super();
	}

	override public function findFocus(other:Null<Hud>):Null<Hud> {
		return this.visible ? this : other;
	}

	override public function interact(input:Input):Bool {
		var axis:InputAxis = input.axis(this.axis);
		if (axis.isTrigger) {
			if (axis.value > 0) {
				if (++this.menu.value >= this.menu.length) this.menu.value--;
			} else if (axis.value < 0) {
				if (--this.menu.value < 0) this.menu.value++;
			}
		}
		var execute:InputAxis = input.axis(this.execute);
		if (execute.isTriggerDown) {
			if (this.menu.selection != null) {
				var proc:Proc = this.menu.selection.proc;
				if (proc != null) {
					proc.execute();
				}
			}
		}
		return true;
	}
}
