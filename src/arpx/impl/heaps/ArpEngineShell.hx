package arpx.impl.heaps;

#if arp_display_backend_heaps

import hxd.App;

import arpx.impl.cross.ArpEngineShellBase;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.geom.Transform;

class ArpEngineShell extends ArpEngineShellBase {

	private var app:ArpEngineApp;

	public function new(params:ArpEngineParams) {
		super(params);
		this.app = new ArpEngineApp(this);
	}

	private var _displayContext:DisplayContext;

	public function createDisplayContext():DisplayContext {
		if (this._displayContext != null) return this._displayContext;
		this._displayContext = new DisplayContext(this.app.s2d, this.width, this.height, new Transform());
		return this._displayContext;
	}
}

private class ArpEngineApp extends App {

	private var shell:ArpEngineShell;

	public function new(shell:ArpEngineShell) {
		this.shell = shell;
		super();
	}

	override function init() @:privateAccess this.shell._start();
	override function update(dt:Float):Void @:privateAccess this.shell.domainRawTick(dt * 60);

	override public function render(e:h3d.Engine):Void {
		s3d.render(e);
		@:privateAccess this.shell._render();
		s2d.render(e);
	}
}
#end
