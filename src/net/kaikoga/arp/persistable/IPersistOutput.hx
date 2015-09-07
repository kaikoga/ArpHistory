package net.kaikoga.arp.persistable;


import flash.utils.ByteArray;

interface IPersistOutput {

	var persistLevel(get, set):Int;

	function writeName(value:String):Void;
	function writePersistable(name:String, value:IPersistable):Void;

	function writeBoolean(name:String, value:Bool):Void;
	function writeInt32(name:String, value:Int):Void;
	function writeUInt32(name:String, value:UInt):Void;
	function writeDouble(name:String, value:Float):Void;

	function writeUtf(name:String, value:String):Void;
	function writeBytes(name:String, bytes:ByteArray, offset:Int = 0, length:Int = 0):Void;
	function writeBlob(name:String, bytes:ByteArray, offset:Int = 0, length:Int = 0):Void;
}

