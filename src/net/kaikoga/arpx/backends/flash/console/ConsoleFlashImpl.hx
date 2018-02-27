package net.kaikoga.arpx.backends.flash.console;

#if (arp_backend_flash || arp_backend_openfl)

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
		for (screen in this.console.screens) screen.display(bitmapData);
	}
}

#end
