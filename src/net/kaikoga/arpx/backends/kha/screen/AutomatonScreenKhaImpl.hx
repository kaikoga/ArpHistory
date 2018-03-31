package net.kaikoga.arpx.backends.kha.screen;

#if arp_backend_kha

import kha.graphics2.Graphics;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.screen.AutomatonScreen;

@:access(net.kaikoga.arpx.screen.AutomatonScreen)
class AutomatonScreenKhaImpl extends ArpObjectImplBase implements IScreenKhaImpl {

	private var screen:AutomatonScreen;

	public function new(screen:AutomatonScreen) {
		super();
		this.screen = screen;
	}

	public function display(g2:Graphics):Void {
		var c:IScreenKhaImpl = screen.screen;
		if (c != null) c.display(g2);
	}
}

#end
