package net.kaikoga.arpx.backends.flash.console;

import flash.display.BitmapData;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.console.CompositeConsole;

class CompositeConsoleFlashImpl extends ArpObjectImplBase implements IConsoleFlashImpl {

	private var console:CompositeConsole;

	public function new(console:CompositeConsole) {
		super();
		this.console = console;
	}

	public function display(bitmapData:BitmapData):Void {
		for (console in this.console.consoles) console.display(bitmapData);
	}
}


