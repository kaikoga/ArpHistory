package net.kaikoga.arpx.backends.kha.console;

#if arp_backend_kha

import flash.display.BitmapData;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.console.Console;

class ConsoleKhaImpl extends ArpObjectImplBase implements IConsoleKhaImpl {

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
