package net.kaikoga.arpx.backends.flash.console;

import flash.display.BitmapData;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.console.Console;
import net.kaikoga.arpx.backends.flash.geom.APoint;

class ConsoleFlashImpl implements IConsoleFlashImpl {

	private var console:Console;

	public function new(console:Console) {
		this.console = console;
	}

	private static var _workPt:APoint = new APoint();

	public function display(bitmapData:BitmapData):Void {
		var workPt:APoint = _workPt;
		//throw this.console.arpDomain().dumpEntries();
		for (camera in this.console.cameras) {
			var pos:ArpPosition = camera.position;
			workPt.x = -pos.x;
			workPt.y = -pos.y;
			camera.field.copySelf(bitmapData, workPt);
		}
		// if (this.console.dissolve) {
		// 	if (this.console.dissolve.frameMove()) {
		// 		context.addElement(this.console.dissolve);
		// 	}
		// 	else {
		// 		this.console.dissolve = null;
		// 	}
		// }
		// for (hud/* AS3HX WARNING could not determine type for var: hud exp: EField(EIdent(this),huds) type: null */ in this.huds) {
		// 	context.addChild(hud);
		// }
	}

	public function frameMove():Void {
		// for (hud/* AS3HX WARNING could not determine type for var: hud exp: EField(EIdent(this),huds) type: null */ in this.huds) {
		// 	hud.frameMove();
		// }
	}


	// public function startDissolve(dissolve:Dissolve):Void {
	// 	dissolve.capture(this, 240, 160);
	// 	this.dissolve = dissolve;
	// }

}


