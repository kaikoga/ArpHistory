package net.kaikoga.arpx.impl.cross.screen;

import net.kaikoga.arpx.impl.ArpObjectImplBase;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.screen.CompositeScreen;

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
