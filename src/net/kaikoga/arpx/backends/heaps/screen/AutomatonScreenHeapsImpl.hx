package net.kaikoga.arpx.backends.heaps.screen;

#if arp_backend_heaps

import h2d.Sprite;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.screen.AutomatonScreen;

@:access(net.kaikoga.arpx.screen.AutomatonScreen)
class AutomatonScreenHeapsImpl extends ArpObjectImplBase implements IScreenHeapsImpl {

	private var screen:AutomatonScreen;

	public function new(screen:AutomatonScreen) {
		super();
		this.screen = screen;
	}

	public function display(buf:Sprite):Void {
		var c:IScreenHeapsImpl = screen.screen;
		if (c != null) c.display(buf);
	}
}

#end
