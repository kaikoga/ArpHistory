package net.kaikoga.arp.persistable;


import flash.utils.ByteArray;

interface IPersistInput {

	var persistLevel(get, never):Int;

	function readName():String;
	function readPersistable(name:String, persistable:IPersistable):Void;

	function readBool(name:String):Bool;
	function readInt32(name:String):Int;
	function readUInt32(name:String):UInt;
	function readDouble(name:String):Float;

	function readUtf(name:String):String;
	function readBytes(name:String, bytes:ByteArray, offset:Int = 0, length:Int = 0):Void;
	function readBlob(name:String, bytes:ByteArray, offset:Int = 0):Void;
}

