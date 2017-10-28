package net.kaikoga.arpx.backends.flash.console;

import flash.display.BitmapData;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.console.CameraConsole;

class CameraConsoleFlashImpl extends ArpObjectImplBase implements IConsoleFlashImpl {

	private var console:CameraConsole;

	public function new(console:CameraConsole) {
		super();
		this.console = console;
	}

	public function display(bitmapData:BitmapData):Void {
		for (camera in this.console.cameras) camera.display(bitmapData);
	}
}


