package arpx.impl.stub;

#if arp_display_backend_stub

import arpx.impl.cross.ArpEngineShellBase;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.geom.Transform;

class ArpEngineShell extends ArpEngineShellBase {

	public function new(params:ArpEngineParams) super(params);

	private var _displayContext:DisplayContext;

	public function createDisplayContext():DisplayContext {
		if (this._displayContext != null) return this._displayContext;
		this._displayContext = new DisplayContext(this.width, this.height, new Transform(), this.clearColor);
		return this._displayContext;
	}
}

#end
