package net.kaikoga.arpx.backends.flash.console;

import flash.display.BitmapData;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.console.ScreenConsole;

class ScreenConsoleFlashImpl extends ArpObjectImplBase implements IConsoleFlashImpl {

	private var console:ScreenConsole;

	public function new(console:ScreenConsole) {
		super();
		this.console = console;
	}

	public function display(bitmapData:BitmapData):Void {
		for (screen in this.console.screens) screen.display(bitmapData);
	}
}


