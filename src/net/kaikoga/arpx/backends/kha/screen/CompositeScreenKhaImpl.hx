package net.kaikoga.arpx.backends.kha.screen;

#if arp_backend_kha

import kha.graphics2.Graphics;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.screen.CompositeScreen;

class CompositeScreenKhaImpl extends ArpObjectImplBase implements IScreenKhaImpl {

	private var screen:CompositeScreen;

	public function new(screen:CompositeScreen) {
		super();
		this.screen = screen;
	}

	public function display(g2:Graphics):Void {
		for (screen in this.screen.screens) screen.display(g2);
	}
}

#end
