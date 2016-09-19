package net.kaikoga.arpx.backends.flash.socketClient;

import net.kaikoga.arp.io.flash.DataOutputWrapper;
import net.kaikoga.arp.io.flash.DataInputWrapper;
import haxe.io.Bytes;
import net.kaikoga.arpx.backends.cross.socketClient.ISocketClientImpl;
import net.kaikoga.arp.io.Pipe;
import net.kaikoga.arpx.socketClient.TcpCachedSocketClient;
import net.kaikoga.arp.events.IArpSignalIn;
import net.kaikoga.arp.events.ArpProgressEvent;
import net.kaikoga.arp.events.ArpSignal;
import flash.events.ProgressEvent;
import flash.events.IOErrorEvent;
import flash.events.Event;
import flash.net.Socket;

class TcpCachedSocketClientFlashImpl implements ISocketClientImpl {

	private var socketClient:TcpCachedSocketClient;
	private var onData:IArpSignalIn<ArpProgressEvent>;

	public var bigEndian(get, set):Bool;
	inline public function get_bigEndian():Bool return false;
	inline public function set_bigEndian(value:Bool):Bool return false;

	public function new(socketClient:TcpCachedSocketClient, onData:ArpSignal<ArpProgressEvent>) {
		this.socketClient = socketClient;
		this.onData = onData;
		this.inPipe = new Pipe();
		this.inPipe.bigEndian = true;
		this.outPipe = new Pipe();
		this.outPipe.bigEndian = true;
	}

	private var socket:Socket;
	private var output:DataOutputWrapper;
	private var input:DataInputWrapper;
	private var outPipe:Pipe;
	private var inPipe:Pipe;

	public function heatUp():Bool {
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
		this.inPipe.writeBytes(bytes, 0, bytes.length);
		if (this.onData.willTrigger()) this.onData.dispatch(new ArpProgressEvent(event.bytesLoaded, event.bytesTotal));
	}

	@:access(net.kaikoga.arp.io.Pipe.bytesAvailable)
	private function flush():Void {
		if (this.output != null) this.output.writeBytes(this.outPipe.nextBytes(this.outPipe.bytesAvailable));
	}

	public function heatDown():Bool {
		this.input = null;
		this.output = null;
		this.socket.close();
		this.socket = null;
		return true;
	}

	inline public function readBool():Bool return inPipe.readBool();
	inline public function readInt8():Int return inPipe.readInt8();
	inline public function readInt16():Int return inPipe.readInt16();
	inline public function readInt32():Int return inPipe.readInt32();
	inline public function readUInt8():UInt return inPipe.readUInt8();
	inline public function readUInt16():UInt return inPipe.readUInt16();
	inline public function readUInt32():UInt return inPipe.readUInt32();
	inline public function readFloat():Float return inPipe.readFloat();
	inline public function readDouble():Float return inPipe.readDouble();
	inline public function readBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void inPipe.readBytes(bytes, offset, length);
	inline public function readUtfBytes(length:UInt):String return inPipe.readUtfBytes(length);
	inline public function readBlob():Bytes return inPipe.readBlob();
	inline public function readUtfBlob():String return inPipe.readUtfBlob();
	inline public function nextBytes(limit:Int = 0):Bytes return inPipe.nextBytes(limit);

	inline public function writeBool(value:Bool):Void { outPipe.writeBool(value); flush(); }
	inline public function writeInt8(value:Int):Void { outPipe.writeInt8(value); flush(); }
	inline public function writeInt16(value:Int):Void { outPipe.writeInt16(value); flush(); }
	inline public function writeInt32(value:Int):Void { outPipe.writeInt32(value); flush(); }
	inline public function writeUInt8(value:UInt):Void { outPipe.writeUInt8(value); flush(); }
	inline public function writeUInt16(value:UInt):Void { outPipe.writeUInt16(value); flush(); }
	inline public function writeUInt32(value:UInt):Void { outPipe.writeUInt32(value); flush(); }
	inline public function writeFloat(value:Float):Void { outPipe.writeFloat(value); flush(); }
	inline public function writeDouble(value:Float):Void { outPipe.writeDouble(value); flush(); }
	inline public function writeBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void { outPipe.writeBytes(bytes, offset, length); flush(); }
	inline public function writeUtfBytes(value:String):Void { outPipe.writeUtfBytes(value); flush(); }
	inline public function writeBlob(bytes:Bytes):Void { outPipe.writeBlob(bytes); flush(); }
	inline public function writeUtfBlob(value:String):Void { outPipe.writeUtfBlob(value); flush(); }

}


