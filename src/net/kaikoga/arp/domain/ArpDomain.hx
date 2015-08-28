package net.kaikoga.arp.domain;

import net.kaikoga.arp.domain.core.ArpSid;
import net.kaikoga.arp.domain.core.ArpDid;

class ArpDomain {

	public var root(default, null):ArpDirectory;

	public function new() {
		this.root = new ArpDirectory(this, this.nextDid());
	}

	public function nextDid():ArpDid {
		return new ArpDid("");
	}
	
	public function nextSid():ArpSid {
		return new ArpSid("");
	}
}
