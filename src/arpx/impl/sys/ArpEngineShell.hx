package arpx.impl.sys;

#if arp_display_backend_sys

import arpx.impl.cross.ArpEngineShellBase;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.geom.ArpTransform;

class ArpEngineShell extends ArpEngineShellBase {

	public function new(params:ArpEngineParams) super(params);

	override private function createDisplayContext():DisplayContext {
		return new DisplayContext(this.width, this.height, new ArpTransform(), this.clearColor);
	}
}

#end
