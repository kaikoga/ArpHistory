package net.kaikoga.arpx.backends.flash.console;

import flash.display.BitmapData;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.console.Console;

class ConsoleFlashImpl extends ArpObjectImplBase implements IConsoleFlashImpl {

	private var console:Console;

	public function new(console:Console) {
		super();
		this.console = console;
	}

	public function display(bitmapData:BitmapData):Void {
		for (camera in this.console.cameras) camera.display(bitmapData);
	}
}


