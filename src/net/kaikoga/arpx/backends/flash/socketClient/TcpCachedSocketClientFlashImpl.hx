package net.kaikoga.arpx.backends.flash.socketClient;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arp.io.flash.DataOutputWrapper;
import net.kaikoga.arp.io.flash.DataInputWrapper;
import haxe.io.Bytes;
import net.kaikoga.arpx.backends.cross.socketClient.ISocketClientImpl;
import net.kaikoga.arp.io.Fifo;
import net.kaikoga.arpx.socketClient.TcpCachedSocketClient;
import net.kaikoga.arp.events.IArpSignalIn;
import net.kaikoga.arp.events.ArpProgressEvent;
import flash.events.ProgressEvent;
import flash.events.IOErrorEvent;
import flash.events.Event;
import flash.net.Socket;

class TcpCachedSocketClientFlashImpl extends ArpObjectImplBase implements ISocketClientImpl {

	private var socketClient:TcpCachedSocketClient;
	private var onData:IArpSignalIn<ArpProgressEvent>;

	public var bigEndian(get, set):Bool;
	inline public function get_bigEndian():Bool return false;
	inline public function set_bigEndian(value:Bool):Bool return false;

	public function new(socketClient:TcpCachedSocketClient) {
		super();
		this.socketClient = socketClient;
		this.onData = socketClient._onData;
		this.inFifo = new Fifo();
		this.inFifo.bigEndian = true;
		this.outFifo = new Fifo();
		this.outFifo.bigEndian = true;
	}

	private var socket:Socket;
	private var output:DataOutputWrapper;
	private var input:DataInputWrapper;
	private var outFifo:Fifo;
	private var inFifo:Fifo;

	override public function arpHeatUp():Bool {
		if (this.socketClient.host == null) {
			return true;
		}
		if (this.socket != null) {
			return true;
		}
		this.socket = new Socket();
		var host:String = "127.0.0.1";
		var port:Int = 57772;
		var array:Array<String> = this.socketClient.host.split(":");
		if (array[0] != null) host = array[0];
		if (array[1] != null) try { port = Std.parseInt(array[1]); } catch(d:Dynamic) {}
		this.socket.addEventListener(Event.CONNECT, this.onSocketConnect);
		this.socket.addEventListener(IOErrorEvent.IO_ERROR, this.onSocketIoError);
		this.socket.addEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
		this.socket.connect(host, port);
		// this.socketClient.arpDomain.waitFor(this.socketClient);
		return true;
	}

	private function onSocketConnect(event:Event):Void {
		// this.socketClient.arpDomain.notifyFor(this.socketClient);
		this.input = new DataInputWrapper(this.socket);
		this.output = new DataOutputWrapper(this.socket);
		this.input.bigEndian = true;
		this.output.bigEndian = true;
	}

	private function onSocketIoError(event:IOErrorEvent):Void {
		this.socketClient.arpDomain.notifyFor(this.socketClient);
		this.socket = null;
	}

	private function onSocketData(event:ProgressEvent):Void {
		var bytes:Bytes = this.input.nextBytes(this.socket.bytesAvailable);
		this.inFifo.writeBytes(bytes, 0, bytes.length);
		if (this.onData.willTrigger()) this.onData.dispatch(new ArpProgressEvent(event.bytesLoaded, event.bytesTotal));
	}

	@:access(net.kaikoga.arp.io.Fifo.bytesAvailable)
	private function flush():Void {
		if (this.output != null) this.output.writeBytes(this.outFifo.nextBytes(this.outFifo.bytesAvailable));
	}

	override public function arpHeatDown():Bool {
		this.input = null;
		this.output = null;
		this.socket.close();
		this.socket = null;
		return true;
	}

	inline public function readBool():Bool return inFifo.readBool();
	inline public function readInt8():Int return inFifo.readInt8();
	inline public function readInt16():Int return inFifo.readInt16();
	inline public function readInt32():Int return inFifo.readInt32();
	inline public function readUInt8():UInt return inFifo.readUInt8();
	inline public function readUInt16():UInt return inFifo.readUInt16();
	inline public function readUInt32():UInt return inFifo.readUInt32();
	inline public function readFloat():Float return inFifo.readFloat();
	inline public function readDouble():Float return inFifo.readDouble();
	inline public function readBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void inFifo.readBytes(bytes, offset, length);
	inline public function readUtfBytes(length:UInt):String return inFifo.readUtfBytes(length);
	inline public function readBlob():Bytes return inFifo.readBlob();
	inline public function readUtfBlob():String return inFifo.readUtfBlob();
	inline public function nextBytes(limit:Int = 0):Bytes return inFifo.nextBytes(limit);

	inline public function writeBool(value:Bool):Void { outFifo.writeBool(value); flush(); }
	inline public function writeInt8(value:Int):Void { outFifo.writeInt8(value); flush(); }
	inline public function writeInt16(value:Int):Void { outFifo.writeInt16(value); flush(); }
	inline public function writeInt32(value:Int):Void { outFifo.writeInt32(value); flush(); }
	inline public function writeUInt8(value:UInt):Void { outFifo.writeUInt8(value); flush(); }
	inline public function writeUInt16(value:UInt):Void { outFifo.writeUInt16(value); flush(); }
	inline public function writeUInt32(value:UInt):Void { outFifo.writeUInt32(value); flush(); }
	inline public function writeFloat(value:Float):Void { outFifo.writeFloat(value); flush(); }
	inline public function writeDouble(value:Float):Void { outFifo.writeDouble(value); flush(); }
	inline public function writeBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void { outFifo.writeBytes(bytes, offset, length); flush(); }
	inline public function writeUtfBytes(value:String):Void { outFifo.writeUtfBytes(value); flush(); }
	inline public function writeBlob(bytes:Bytes):Void { outFifo.writeBlob(bytes); flush(); }
	inline public function writeUtfBlob(value:String):Void { outFifo.writeUtfBlob(value); flush(); }

}


