package arpx.impl.stub;

#if arp_display_backend_stub

import arp.domain.ArpDomain;
import arpx.impl.cross.ArpEngineShellBase;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.structs.ArpTransform;

class ArpEngineShell extends ArpEngineShellBase {

	public function new(domain:ArpDomain, params:ArpEngineParams) super(domain, params);

	override private function createDisplayContext():DisplayContext {
		return new DisplayContext(this.width, this.height, new ArpTransform(), this.clearColor);
	}
}

#end
