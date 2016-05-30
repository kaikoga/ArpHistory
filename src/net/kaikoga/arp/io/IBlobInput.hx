package net.kaikoga.arp.io;

import haxe.io.Bytes;

interface IBlobInput {
	function nextUtfBlob():Null<String>;
	function nextBlob():Null<Bytes>;
}

