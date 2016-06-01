package net.kaikoga.arpx.socketClient;

import net.kaikoga.arp.events.ArpProgressEvent;
import net.kaikoga.arp.events.ArpSignal;
import haxe.io.Bytes;
import net.kaikoga.arp.events.IArpSignalOut;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.backends.cross.socketClient.ISocketClientImpl;
import net.kaikoga.arpx.backends.cross.socketClient.SocketClientNullImpl;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("socketClient", "null"))
class SocketClient implements IArpObject implements ISocketClientImpl {

	public var bigEndian(get, set):Bool;
	private function get_bigEndian():Bool return this.impl.bigEndian;
	private function set_bigEndian(value:Bool):Bool return this.impl.bigEndian = value;

	private var impl:ISocketClientImpl;

	private function createImpl(onData:ArpSignal<ArpProgressEvent>):ISocketClientImpl return new SocketClientNullImpl();

	private var _onData:ArpSignal<ArpProgressEvent>;
	public var onData(get, never):IArpSignalOut<ArpProgressEvent>;
	private function get_onData():IArpSignalOut<ArpProgressEvent> return this._onData;

	public function new() {
		this._onData = new ArpSignal<ArpProgressEvent>();
		impl = createImpl(this._onData);
	}

	inline public function readBool():Bool return impl.readBool();
	inline public function readInt8():Int return impl.readInt8();
	inline public function readInt16():Int return impl.readInt16();
	inline public function readInt32():Int return impl.readInt32();
	inline public function readUInt8():UInt return impl.readUInt8();
	inline public function readUInt16():UInt return impl.readUInt16();
	inline public function readUInt32():UInt return impl.readUInt32();
	inline public function readFloat():Float return impl.readFloat();
	inline public function readDouble():Float return impl.readDouble();
	inline public function readBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void return impl.readBytes(bytes, offset, length);
	inline public function readUtfBytes(length:UInt):String return impl.readUtfBytes(length);
	inline public function readBlob():Bytes return impl.readBlob();
	inline public function readUtfBlob():String return impl.readUtfBlob();
	inline public function nextBytes(limit:Int = 0):Bytes return impl.nextBytes(limit);

	inline public function writeBool(value:Bool):Void impl.writeBool(value);
	inline public function writeInt8(value:Int):Void impl.writeInt8(value);
	inline public function writeInt16(value:Int):Void impl.writeInt16(value);
	inline public function writeInt32(value:Int):Void impl.writeInt32(value);
	inline public function writeUInt8(value:UInt):Void impl.writeUInt8(value);
	inline public function writeUInt16(value:UInt):Void impl.writeUInt16(value);
	inline public function writeUInt32(value:UInt):Void impl.writeUInt32(value);
	inline public function writeFloat(value:Float):Void impl.writeFloat(value);
	inline public function writeDouble(value:Float):Void impl.writeDouble(value);
	inline public function writeBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void impl.writeBytes(bytes, offset, length);
	inline public function writeUtfBytes(value:String):Void impl.writeUtfBytes(value);
	inline public function writeBlob(bytes:Bytes):Void impl.writeBlob(bytes);
	inline public function writeUtfBlob(value:String):Void impl.writeUtfBlob(value);

	@:arpHeatUp public function heatUp():Bool return this.impl.heatUp();
	@:arpHeatDown public function heatDown():Bool return this.impl.heatDown();
}


