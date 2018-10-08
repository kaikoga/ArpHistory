package arpx;

import arp.domain.ArpDomain;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.ArpEngineShell;

class ArpEngine {

	public var shell(default, null):ArpEngineShell;

	public var domain(get, never):ArpDomain;
	inline private function get_domain():ArpDomain return shell.domain;

	public var displayContext(get, never):DisplayContext;
	inline public function get_displayContext():DisplayContext return shell.displayContext;

	public function new(params:ArpEngineParams) {
		this.shell = new ArpEngineShell(params);
	}
}
