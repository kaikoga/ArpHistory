package net.kaikoga.arpx.storage;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.backends.cross.storage.IStorageImpl;

@:arpType("storage", "null")
class Storage implements IStorageImpl implements IArpObject {

	@:arpImpl private var impl:IStorageImpl;

	public function new () {
	}
}
