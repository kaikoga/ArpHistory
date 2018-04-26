package net.kaikoga.arpx.backends.flash.screen;

#if (arp_backend_flash || arp_backend_openfl)

import net.kaikoga.arpx.backends.flash.display.DisplayContext;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.screen.AutomatonScreen;

class AutomatonScreenFlashImpl extends ArpObjectImplBase implements IScreenFlashImpl {

	private var screen:AutomatonScreen;

	public function new(screen:AutomatonScreen) {
		super();
		this.screen = screen;
	}

	public function display(context:DisplayContext):Void {
		var c:IScreenFlashImpl = @:privateAccess screen.screen;
		if (c != null) c.display(context);
	}
}

#end
