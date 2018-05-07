package net.kaikoga.arpx.impl.backends.flash.console;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import net.kaikoga.arpx.impl.ArpObjectImplBase;
import net.kaikoga.arpx.impl.backends.flash.display.DisplayContext;
import net.kaikoga.arpx.console.Console;

class ConsoleFlashImpl extends ArpObjectImplBase implements IConsoleFlashImpl {

	private var console:Console;

	public function new(console:Console) {
		super();
		this.console = console;
	}

	public function display(bitmapData:BitmapData):Void {
		var context:DisplayContext = new DisplayContext(bitmapData);
		context.start();
		this.render(context);
		context.display();
	}

	public function render(context:DisplayContext):Void {
		for (screen in this.console.screens) screen.display(context);
	}
}

#end
