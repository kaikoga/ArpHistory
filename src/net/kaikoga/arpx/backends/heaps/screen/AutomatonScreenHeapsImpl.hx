package net.kaikoga.arpx.backends.heaps.screen;

#if arp_backend_heaps

import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.screen.AutomatonScreen;

@:access(net.kaikoga.arpx.screen.AutomatonScreen)
class AutomatonScreenHeapsImpl extends ArpObjectImplBase implements IScreenHeapsImpl {

	private var screen:AutomatonScreen;

	public function new(screen:AutomatonScreen) {
		super();
		this.screen = screen;
	}

	public function display(context:DisplayContext):Void {
		var c:IScreenHeapsImpl = screen.screen;
		if (c != null) c.display(context);
	}
}

#end
