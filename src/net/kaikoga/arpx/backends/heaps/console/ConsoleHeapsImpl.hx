package net.kaikoga.arpx.backends.heaps.console;

#if arp_backend_heaps

import h2d.Sprite;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.console.Console;

class ConsoleHeapsImpl extends ArpObjectImplBase implements IConsoleHeapsImpl {

	private var console:Console;

	public function new(console:Console) {
		super();
		this.console = console;
	}

	public function display(buf:Sprite):Void {
		for (screen in this.console.screens) screen.display(buf);
	}
}

#end
