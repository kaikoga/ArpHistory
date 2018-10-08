package arpx;

import arp.domain.ArpDomain;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.ArpEngineShell;

class ArpEngine {

	public var domain(default, null):ArpDomain;
	public var params(default, null):ArpEngineParams;

	public var shell(default, null):ArpEngineShell;

	public var displayContext(get, never):DisplayContext;
	inline public function get_displayContext():DisplayContext return shell.displayContext;

	public function new(domain:ArpDomain, params:ArpEngineParams) {
		this.domain = domain;
		this.params = params;
	}

	public function start():Void {
		this.shell = new ArpEngineShell(domain, params);
	}
}
