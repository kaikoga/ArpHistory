package arpx.impl.backends.heaps.console;

#if arp_display_backend_heaps

import h2d.Sprite;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.backends.heaps.display.DisplayContext;
import arpx.console.Console;

class ConsoleHeapsImpl extends ArpObjectImplBase implements IConsoleHeapsImpl {

	private var console:Console;

	public function new(console:Console) {
		super();
		this.console = console;
	}

	public function display(sprite:Sprite):Void {
		var context:DisplayContext = new DisplayContext(sprite, console.width, console.height);
		context.start();
		this.render(context);
		context.display();
	}

	public function render(context:DisplayContext):Void {
		for (screen in this.console.screens) screen.display(context);
	}
}

#end
