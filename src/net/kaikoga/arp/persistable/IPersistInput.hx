package net.kaikoga.arp.persistable;

import haxe.io.Bytes;

interface IPersistInput {

	var persistLevel(get, never):Int;

	function readEnter(name:String):IPersistInput;
	function readExit():Void;

	function readNameList(name:String):Array<String>;
	function readPersistable(name:String, persistable:IPersistable):Void;

	function readBool(name:String):Bool;
	function readInt32(name:String):Int;
	function readUInt32(name:String):UInt;
	function readDouble(name:String):Float;

	function readUtf(name:String):String;
	function readBlob(name:String):Bytes;
}

