package arpx.impl.cross.screen;

import arpx.display.DisplayContext;
import arpx.impl.ArpObjectImplBase;
import arpx.screen.CompositeScreen;

class CompositeScreenImpl extends ArpObjectImplBase implements IScreenImpl {

	private var screen:CompositeScreen;

	public function new(screen:CompositeScreen) {
		super();
		this.screen = screen;
	}

	public function display(context:DisplayContext):Void {
		for (screen in this.screen.screens) screen.display(context);
	}
}
