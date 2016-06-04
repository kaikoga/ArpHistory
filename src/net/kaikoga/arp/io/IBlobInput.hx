package net.kaikoga.arp.io;

import haxe.io.Bytes;

interface IBlobInput {
	var bigEndian(get, set):Bool;
	function nextUtfBlob():Null<String>;
	function nextBlob():Null<Bytes>;
}

