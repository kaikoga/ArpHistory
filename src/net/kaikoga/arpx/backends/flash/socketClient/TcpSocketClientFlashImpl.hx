package net.kaikoga.arpx.backends.flash.socketClient;

import net.kaikoga.arpx.backends.cross.socketClient.SocketClientImplBase;
import net.kaikoga.arp.io.OutputWrapper;
import net.kaikoga.arp.io.InputWrapper;
import net.kaikoga.arp.events.IArpSignalIn;
import net.kaikoga.arp.events.ArpProgressEvent;
import net.kaikoga.arp.events.ArpSignal;
import flash.events.ProgressEvent;
import flash.events.IOErrorEvent;
import flash.events.Event;
import flash.net.Socket;
import net.kaikoga.arpx.socketClient.TcpSocketClient;

class TcpSocketClientFlashImpl extends SocketClientImplBase {

	public var bigEndian(get, set):Bool;
	inline public function get_bigEndian():Bool return false;
	inline public function set_bigEndian(value:Bool):Bool return false;

	private var socketClient:TcpSocketClient;
	private var onData:IArpSignalIn<ArpProgressEvent>;

	public function new(socketClient:TcpSocketClient, onData:ArpSignal<ArpProgressEvent>) {
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
		var array:Array<String> = this.host.split(":", 2);
		var host:String = array[0] || "127.0.0.1";
		var port:Int = array[1] || 57771;
		this.socket.addEventListener(Event.CONNECT, this.onSocketConnect);
		this.socket.addEventListener(IOErrorEvent.IO_ERROR, this.onSocketConnect);
		this.socket.addEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
		this.socket.connect(host, port);
		this.socketClient.arpDomain().waitFor(this);
		return false;
	}

	private function onSocketConnect(event:Event):Void {
		this.socketClient.arpDomain().notifyWaitFor(this);
		this.input = new InputWrapper(this.socket);
		this.output = new OutputWrapper(this.socket);
		this.input.bigEndian = true;
		this.output.bigEndian = true;
	}

	private function onSocketIoError(event:IOErrorEvent):Void {
		this.socketClient.arpDomain().notifyWaitFor(this);
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


