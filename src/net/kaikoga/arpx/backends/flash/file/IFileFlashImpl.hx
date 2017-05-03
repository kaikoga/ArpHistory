package net.kaikoga.arpx.backends.flash.file;

import net.kaikoga.arp.backends.IArpObjectImpl;
import haxe.io.Bytes;
import net.kaikoga.arp.io.IInput;

interface IFileFlashImpl extends IArpObjectImpl {
	var exists(get, never):Bool;
	function bytes():Bytes;
	function read():IInput;
}