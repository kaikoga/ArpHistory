package net.kaikoga.arp.domain;

import net.kaikoga.arp.domain.query.ArpDirectoryQuery;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.query.ArpObjectQuery;
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

	inline public function dir(path:String = null):ArpDirectory {
		return new ArpDirectoryQuery(this.root, path).directory();
	}

	inline public function query<T:IArpObject>(path:String = null, type:ArpType = null):ArpObjectQuery<T> {
		return new ArpObjectQuery(this.root, path, type);
	}

}
