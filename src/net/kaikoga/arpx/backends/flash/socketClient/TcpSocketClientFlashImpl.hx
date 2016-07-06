package net.kaikoga.arpx.backends.flash.socketClient;

import net.kaikoga.arp.io.flash.DataOutputWrapper;
import net.kaikoga.arp.io.flash.DataInputWrapper;
import net.kaikoga.arpx.backends.cross.socketClient.SocketClientImplBase;
import net.kaikoga.arp.events.IArpSignalIn;
import net.kaikoga.arp.events.ArpProgressEvent;
import net.kaikoga.arp.events.ArpSignal;
import flash.events.ProgressEvent;
import flash.events.IOErrorEvent;
import flash.events.Event;
import flash.net.Socket;
import net.kaikoga.arpx.socketClient.TcpSocketClient;

class TcpSocketClientFlashImpl extends SocketClientImplBase {

	private var socketClient:TcpSocketClient;
	private var onData:IArpSignalIn<ArpProgressEvent>;

	public function new(socketClient:TcpSocketClient, onData:ArpSignal<ArpProgressEvent>) {
		super();
		this.socketClient = socketClient;
		this.onData = onData;
	}

	private var socket:Socket;

	override public function heatUp():Bool {
		if (this.socketClient.host == null) {
			return true;
		}
		if (this.socket != null) {
			return this.socket.connected;
		}
		this.socket = new Socket();
		var host:String = "127.0.0.1";
		var port:Int = 57772;
		var array:Array<String> = this.socketClient.host.split(":");
		if (array[0] != null) host = array[0];
		if (array[1] != null) try { port = Std.parseInt(array[1]); } catch(d:Dynamic) {}
		this.socket.addEventListener(Event.CONNECT, this.onSocketConnect);
		this.socket.addEventListener(IOErrorEvent.IO_ERROR, this.onSocketConnect);
		this.socket.addEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
		this.socket.connect(host, port);
		this.socketClient.arpDomain().waitFor(this.socketClient);
		return false;
	}

	private function onSocketConnect(event:Event):Void {
		this.socketClient.arpDomain().notifyFor(this.socketClient);
		this.input = new DataInputWrapper(this.socket);
		this.output = new DataOutputWrapper(this.socket);
		this.input.bigEndian = true;
		this.output.bigEndian = true;
	}

	private function onSocketIoError(event:IOErrorEvent):Void {
		this.socketClient.arpDomain().notifyFor(this.socketClient);
		this.socket = null;
	}

	private function onSocketData(event:ProgressEvent):Void {
		if (this.onData.willTrigger()) this.onData.dispatch(new ArpProgressEvent(event.bytesLoaded, event.bytesTotal));
	}

	override public function heatDown():Bool {
		this.input = null;
		this.output = null;
		this.socket.close();
		this.socket = null;
		return true;
	}

}


