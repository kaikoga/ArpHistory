package arpx.impl.stub;

#if arp_display_backend_stub

import arpx.impl.cross.ArpEngineShellBase;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.structs.ArpTransform;

class ArpEngineShell extends ArpEngineShellBase {

	public function new(params:ArpEngineParams) super(params);

	override private function createDisplayContext():DisplayContext {
		return new DisplayContext(this.width, this.height, new ArpTransform(), this.clearColor);
	}
}

#end