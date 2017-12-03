package net.kaikoga.arpx.backends.flash.screen;

import flash.display.BitmapData;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.screen.AutomatonScreen;

@:access(net.kaikoga.arpx.screen.AutomatonScreen)
class AutomatonScreenFlashImpl extends ArpObjectImplBase implements IScreenFlashImpl {

	private var screen:AutomatonScreen;

	public function new(screen:AutomatonScreen) {
		super();
		this.screen = screen;
	}

	public function display(bitmapData:BitmapData):Void {
		var c:IScreenFlashImpl = screen.screen;
		if (c != null) c.display(bitmapData);
	}
}


