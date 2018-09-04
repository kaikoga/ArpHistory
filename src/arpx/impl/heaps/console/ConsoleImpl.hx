package arpx.impl.heaps.console;

#if arp_display_backend_heaps

import h2d.Sprite;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.display.RenderContext;
import arpx.console.Console;

class ConsoleImpl extends ArpObjectImplBase implements IConsoleImpl {

	private var console:Console;

	public function new(console:Console) {
		super();
		this.console = console;
	}

	public function display(sprite:Sprite):Void {
		var context:RenderContext = new DisplayContext(sprite, console.width, console.height).renderContext();
		this.console.render(context);
		context.display();
	}
}

#end
