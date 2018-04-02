package net.kaikoga.arpx.backends.cross.storage;

import haxe.io.Bytes;
import net.kaikoga.arp.backends.IArpObjectImpl;

interface IStorageImpl extends IArpObjectImpl {
	var bytes(get, set):Null<Bytes>;
}
