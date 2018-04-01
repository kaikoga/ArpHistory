package net.kaikoga.arpx.backends.cross.file;

import haxe.io.Bytes;
import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arp.io.IInput;

interface IFileImpl extends IArpObjectImpl {
	var exists(get, never):Bool;
	function bytes():Bytes;
	function read():IInput;
}
