package net.kaikoga.arpx.backends.flash.console;

import flash.display.BitmapData;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.console.AutomatonConsole;

@:access(net.kaikoga.arpx.console.AutomatonConsole)
class AutomatonConsoleFlashImpl extends ArpObjectImplBase implements IConsoleFlashImpl {

	private var console:AutomatonConsole;

	public function new(console:AutomatonConsole) {
		super();
		this.console = console;
	}

	public function display(bitmapData:BitmapData):Void {
		var c:IConsoleFlashImpl = console.console;
		if (c != null) c.display(bitmapData);
	}
}


