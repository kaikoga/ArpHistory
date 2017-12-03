package net.kaikoga.arpx.backends.flash.screen;

import flash.display.BitmapData;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.geom.APoint;
import net.kaikoga.arpx.screen.HudScreen;

class HudScreenFlashImpl extends ArpObjectImplBase implements IScreenFlashImpl {

	private var console:HudScreen;

	public function new(console:HudScreen) {
		super();
		this.console = console;
	}

	public function display(bitmapData:BitmapData):Void {
		for (chip in this.console.chips) chip.copyChip(bitmapData, new APoint(), new ArpParams());
	}
}


