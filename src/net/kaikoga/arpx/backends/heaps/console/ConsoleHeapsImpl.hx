package net.kaikoga.arpx.backends.heaps.console;

#if arp_backend_heaps

import h2d.Sprite;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.console.Console;

class ConsoleHeapsImpl extends ArpObjectImplBase implements IConsoleHeapsImpl {

	private var console:Console;

	public function new(console:Console) {
		super();
		this.console = console;
	}

	public function display(sprite:Sprite):Void {
		this.render(new DisplayContext(sprite, console.width, console.height));
	}

	public function render(context:DisplayContext):Void {
		for (screen in this.console.screens) screen.display(context);
	}
}

#end
