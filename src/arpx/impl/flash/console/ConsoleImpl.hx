package arpx.impl.flash.console;

#if (arp_display_backend_flash || arp_display_backend_openfl)

import flash.display.BitmapData;
import arpx.console.Console;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.display.DisplayContext;

class ConsoleImpl extends ArpObjectImplBase implements IConsoleImpl {

	private var console:Console;

	public function new(console:Console) {
		super();
		this.console = console;
	}

	public function display(bitmapData:BitmapData):Void {
		var context:DisplayContext = new DisplayContext(bitmapData);
		context.start();
		this.console.render(context);
		context.display();
	}
}

#end
