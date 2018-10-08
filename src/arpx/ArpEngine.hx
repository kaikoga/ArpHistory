package arpx;

import arp.domain.ArpDomain;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.ArpEngineShell;

class ArpEngine {

	public var domain(default, null):ArpDomain;
	public var config(default, null):ArpEngineConfig;

	public var shell(default, null):ArpEngineShell;

	public var displayContext(get, never):DisplayContext;
	inline public function get_displayContext():DisplayContext return shell.displayContext;

	public function new(domain:ArpDomain) {
		this.domain = domain;
		this.config = new ArpEngineConfig();
	}

	public function start():Void {
		var config = this.config;
		this.config = null;
		this.shell = new ArpEngineShell(domain, config);
	}
}
