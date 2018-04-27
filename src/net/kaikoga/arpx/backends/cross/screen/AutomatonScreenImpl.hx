package net.kaikoga.arpx.backends.cross.screen;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.screen.AutomatonScreen;

class AutomatonScreenImpl extends ArpObjectImplBase implements IScreenImpl {

	private var screen:AutomatonScreen;

	public function new(screen:AutomatonScreen) {
		super();
		this.screen = screen;
	}

	public function display(context:DisplayContext):Void {
		var c:IScreenImpl = @:privateAccess screen.screen;
		if (c != null) c.display(context);
	}
}
