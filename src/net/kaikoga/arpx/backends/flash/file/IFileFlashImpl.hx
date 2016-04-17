package net.kaikoga.arpx.backends.flash.file;

import haxe.io.Bytes;
import net.kaikoga.arp.io.IInput;

interface IFileFlashImpl {
	function bytes():Bytes;
	function read():IInput;
}
