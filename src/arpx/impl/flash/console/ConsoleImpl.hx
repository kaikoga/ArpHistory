package arpx.impl.flash.console;

#if arp_display_backend_flash

import flash.display.BitmapData;
import arpx.console.Console;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.display.RenderContext;

class ConsoleImpl extends ArpObjectImplBase implements IConsoleImpl {

	private var console:Console;

	public function new(console:Console) {
		super();
		this.console = console;
	}

	public function display(bitmapData:BitmapData):Void {
		var context:RenderContext = new DisplayContext(bitmapData).renderContext();
		this.console.render(context);
		context.display();
	}
}

#end
