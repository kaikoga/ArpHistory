package net.kaikoga.arp.persistable;

import haxe.io.Bytes;

interface IPersistOutput {

	var persistLevel(get, never):Int;

	function writeName(value:String):Void;
	function writePersistable(name:String, value:IPersistable):Void;

	function writeBool(name:String, value:Bool):Void;
	function writeInt32(name:String, value:Int):Void;
	function writeUInt32(name:String, value:UInt):Void;
	function writeDouble(name:String, value:Float):Void;

	function writeUtf(name:String, value:String):Void;
	function writeBlob(name:String, bytes:Bytes):Void;
}

