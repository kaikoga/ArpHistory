package arpx.impl.stub.console;

#if arp_display_backend_stub

import arpx.impl.ArpObjectImplBase;
import arpx.impl.stub.display.DisplayContext;
import arpx.console.Console;

class ConsoleImpl extends ArpObjectImplBase implements IConsoleImpl {

	private var console:Console;

	public function new(console:Console) {
		super();
		this.console = console;
	}

	public function display():Void {
		var context:DisplayContext = new DisplayContext(console.width, console.height);
		context.start();
		this.render(context);
		context.display();
	}

	public function render(context:DisplayContext):Void {
		for (screen in this.console.screens) screen.display(context);
	}
}

#end
