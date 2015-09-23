package net.kaikoga.arp.domain.ds;

class ArpObjectList<T:IArpObject> extends List<T> {
	private var domain:ArpDomain;

	public function new(domain:ArpDomain) {
		super();
		this.domain = domain;
	}
}
