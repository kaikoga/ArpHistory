package arpx.impl.backends.flash.console;

#if (arp_display_backend_flash || arp_display_backend_openfl)

import flash.display.BitmapData;
import arpx.console.Console;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.backends.flash.display.DisplayContext;

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
