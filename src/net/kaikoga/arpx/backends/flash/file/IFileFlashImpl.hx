package net.kaikoga.arpx.backends.flash.file;

import haxe.io.Bytes;
import net.kaikoga.arp.io.IInput;

interface IFileFlashImpl {
	var exists(get, never):Bool;
	function bytes():Bytes;
	function read():IInput;
}
