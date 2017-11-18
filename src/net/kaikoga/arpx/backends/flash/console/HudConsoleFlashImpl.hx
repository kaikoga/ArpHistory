package net.kaikoga.arpx.backends.flash.console;

import net.kaikoga.arpx.backends.flash.geom.APoint;
import net.kaikoga.arp.structs.ArpParams;
import flash.display.BitmapData;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.console.HudConsole;

class HudConsoleFlashImpl extends ArpObjectImplBase implements IConsoleFlashImpl {

	private var console:HudConsole;

	public function new(console:HudConsole) {
		super();
		this.console = console;
	}

	public function display(bitmapData:BitmapData):Void {
		for (chip in this.console.chips) chip.copyChip(bitmapData, new APoint(), new ArpParams());
	}
}


