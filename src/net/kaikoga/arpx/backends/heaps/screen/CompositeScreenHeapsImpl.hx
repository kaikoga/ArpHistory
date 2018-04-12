package net.kaikoga.arpx.backends.heaps.screen;

#if arp_backend_heaps

import h2d.Sprite;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.screen.CompositeScreen;

class CompositeScreenHeapsImpl extends ArpObjectImplBase implements IScreenHeapsImpl {

	private var screen:CompositeScreen;

	public function new(screen:CompositeScreen) {
		super();
		this.screen = screen;
	}

	public function display(buf:Sprite):Void {
		for (screen in this.screen.screens) screen.display(buf);
	}
}

#end
