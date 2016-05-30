package net.kaikoga.arp.io;

import haxe.io.Bytes;

interface IBlobOutput {
	function writeBlob(value:Bytes):Void;
	function writeUtfBlob(value:String):Void;
}
