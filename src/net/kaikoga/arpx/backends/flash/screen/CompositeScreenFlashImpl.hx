package net.kaikoga.arpx.backends.flash.screen;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.screen.CompositeScreen;

class CompositeScreenFlashImpl extends ArpObjectImplBase implements IScreenFlashImpl {

	private var screen:CompositeScreen;

	public function new(screen:CompositeScreen) {
		super();
		this.screen = screen;
	}

	public function display(bitmapData:BitmapData):Void {
		for (screen in this.screen.screens) screen.display(bitmapData);
	}
}

#end
