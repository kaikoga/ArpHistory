package net.kaikoga.arpx.backends.flash.socketClient;

import flash.errors.SecurityError;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.Socket;
import net.kaikoga.arp.events.ArpProgressEvent;
import net.kaikoga.arp.events.IArpSignalIn;
import net.kaikoga.arp.io.flash.DataInputWrapper;
import net.kaikoga.arp.io.flash.DataOutputWrapper;
import net.kaikoga.arpx.backends.cross.socketClient.SocketClientImplBase;
import net.kaikoga.arpx.socketClient.TcpSocketClient;

class TcpSocketClientFlashImpl extends SocketClientImplBase {

	private var socketClient:TcpSocketClient;
	private var onData:IArpSignalIn<ArpProgressEvent>;
	private var onClose:IArpSignalIn<Any>;

	public function new(socketClient:TcpSocketClient) {
		super();
		this.socketClient = socketClient;
		this.onData = socketClient._onData;
		this.onClose = socketClient._onClose;
	}

	private var socket:Socket;

	override public function arpHeatUp():Bool {
		if (this.socketClient.host == null) {
			return true;
		}
		if (this.socket != null) {
			return this.socket.connected;
		}
		this.socket = new Socket();
		this.socket.addEventListener(Event.CONNECT, this.onSocketConnect);
		this.socket.addEventListener(IOErrorEvent.IO_ERROR, this.onSocketError);
		this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSocketError);
		this.socket.addEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
		this.socket.addEventListener(Event.CLOSE, this.onSocketClose);
		this.connect();
		this.socketClient.arpDomain.waitFor(this.socketClient);
		return false;
	}

	private function connect():Void {
		var host:String = "127.0.0.1";
		var port:Int = 57772;
		var array:Array<String> = this.socketClient.host.split(":");
		if (array[0] != null) host = array[0];
		if (array[1] != null) try { port = Std.parseInt(array[1]); } catch(d:Dynamic) {}
		try {
			this.socket.connect(host, port);
		} catch (e:SecurityError) {
			this.socketClient.arpDomain.log("socketClient", e.message());
			onSocketError(null);
		}
	}

	private function onSocketConnect(event:Event):Void {
		this.socketClient.arpDomain.notifyFor(this.socketClient);
		this.input = new DataInputWrapper(this.socket);
		this.output = new DataOutputWrapper(this.socket);
		this.input.bigEndian = true;
		this.output.bigEndian = true;
	}

	private function onSocketError(event:Event):Void {
		this.socketClient.arpDomain.notifyFor(this.socketClient);
		this.socket = null;
	}

	private function onSocketData(event:ProgressEvent):Void {
		if (this.onData.willTrigger()) this.onData.dispatch(new ArpProgressEvent(event.bytesLoaded, event.bytesTotal));
	}

	private function onSocketClose(event:Event):Void {
		this.onClose.dispatch(null);
	}

	override public function arpHeatDown():Bool {
		this.input = null;
		this.output = null;
		if (this.socket.connected) this.socket.close();
		this.socket = null;
		return true;
	}

}


