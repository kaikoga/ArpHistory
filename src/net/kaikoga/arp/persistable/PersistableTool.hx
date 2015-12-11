package net.kaikoga.arp.persistable;

import haxe.io.Bytes;

class PersistableTool {

	public static function readNullableNameList(me:IPersistInput, name:String):Null<Array<String>> {
		var np:NamePair = me.readNameList(name);
		return if (me.readBool(np.hasValue)) me.readNameList(np.value) else null;
	}

	public static function readNullableBool(me:IPersistInput, name:String):Null<Bool> {
		var np:NamePair = me.readNameList(name);
		return if (me.readBool(np.hasValue)) me.readBool(np.value) else null;
	}

	public static function readNullableInt32(me:IPersistInput, name:String):Null<Int> {
		var np:NamePair = me.readNameList(name);
		return if (me.readBool(np.hasValue)) me.readInt32(np.value) else null;
	}

	public static function readNullableUInt32(me:IPersistInput, name:String):Null<UInt> {
		var np:NamePair = me.readNameList(name);
		return if (me.readBool(np.hasValue)) me.readUInt32(np.value) else null;
	}

	public static function readNullableDouble(me:IPersistInput, name:String):Null<Float> {
		var np:NamePair = me.readNameList(name);
		return if (me.readBool(np.hasValue)) me.readDouble(np.value) else null;
	}

	public static function readNullableUtf(me:IPersistInput, name:String):Null<String> {
		var np:NamePair = me.readNameList(name);
		return if (me.readBool(np.hasValue)) me.readUtf(np.value) else null;
	}

	public static function readNullableBlob(me:IPersistInput, name:String):Null<Bytes> {
		var np:NamePair = me.readNameList(name);
		return if (me.readBool(np.hasValue)) me.readBlob(np.value) else null;
	}

	public static function writeNullableNameList(me:IPersistOutput, name:String, value:Null<Array<String>>):Void {
		var np:NamePair = createNamePair(me, name);
		me.writeBool(np.hasValue, value != null);
		if (value != null) me.writeNameList(np.value, value);
	}

	public static function writeNullableBool(me:IPersistOutput, name:String, value:Null<Bool>):Void {
		var np:NamePair = createNamePair(me, name);
		me.writeBool(np.hasValue, value != null);
		if (value != null) me.writeBool(np.value, value);
	}

	public static function writeNullableInt32(me:IPersistOutput, name:String, value:Null<Int>):Void {
		var np:NamePair = createNamePair(me, name);
		me.writeBool(np.hasValue, value != null);
		if (value != null) me.writeInt32(np.value, value);
	}

	public static function writeNullableUInt32(me:IPersistOutput, name:String, value:Null<Int>):Void {
		var np:NamePair = createNamePair(me, name);
		me.writeBool(np.hasValue, value != null);
		if (value != null) me.writeUInt32(np.value, value);
	}

	public static function writeNullableDouble(me:IPersistOutput, name:String, value:Null<Float>):Void {
		var np:NamePair = createNamePair(me, name);
		me.writeBool(np.hasValue, value != null);
		if (value != null) me.writeDouble(np.value, value);
	}

	public static function writeNullableUtf(me:IPersistOutput, name:String, value:Null<String>):Void {
		var np:NamePair = createNamePair(me, name);
		me.writeBool(np.hasValue, value != null);
		if (value != null) me.writeUtf(np.value, value);
	}

	public static function writeNullableBlob(me:IPersistOutput, name:String, bytes:Null<Bytes>):Void {
		var np:NamePair = createNamePair(me, name);
		me.writeBool(np.hasValue, bytes != null);
		if (bytes != null) me.writeBlob(np.value, bytes);
	}

	inline private static function createNamePair(me:IPersistOutput, name:String):NamePair {
		var np:NamePair = new NamePair([me.genName(), me.genName()]);
		me.writeNameList(name, np);
		return np;
	}
}

abstract NamePair(Array<String>) from Array<String> to Array<String> {
	public var hasValue(get, never):String;
	private function get_hasValue():String return this[0];
	public var value(get, never):String;
	private function get_value():String return this[1];
	
	inline public function new(value:Array<String>) this = value;
}
