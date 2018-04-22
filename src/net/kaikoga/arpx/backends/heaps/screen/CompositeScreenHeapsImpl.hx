package net.kaikoga.arpx.backends.heaps.screen;

#if arp_backend_heaps

import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.screen.CompositeScreen;

class CompositeScreenHeapsImpl extends ArpObjectImplBase implements IScreenHeapsImpl {

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
