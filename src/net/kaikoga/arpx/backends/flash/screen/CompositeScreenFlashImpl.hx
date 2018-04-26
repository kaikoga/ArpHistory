package net.kaikoga.arpx.backends.flash.screen;

#if (arp_backend_flash || arp_backend_openfl)

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.display.DisplayContext;
import net.kaikoga.arpx.screen.CompositeScreen;

class CompositeScreenFlashImpl extends ArpObjectImplBase implements IScreenFlashImpl {

	private var screen:CompositeScreen;

	public function new(screen:CompositeScreen) {
		super();
		this.screen = screen;
	}

	public function display(context:DisplayContext):Void {
		for (screen in this.screen.screens) screen.display(context);
	}
}

#end
