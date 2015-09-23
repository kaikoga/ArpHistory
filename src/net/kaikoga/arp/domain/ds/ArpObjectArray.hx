package net.kaikoga.arp.domain.ds;

class ArpObjectArray<T:IArpObject> extends Array<T> {
	private var domain:ArpDomain;

	public function new(domain:ArpDomain) {
		super();
		this.domain = domain;
	}
}
