package net.kaikoga.arpx.backends.kha.screen;

#if arp_backend_kha

import flash.display.BitmapData;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.screen.CompositeScreen;

class CompositeScreenKhaImpl extends ArpObjectImplBase implements IScreenKhaImpl {

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
