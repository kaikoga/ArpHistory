package arpx.impl.js.audio;

#if arp_audio_backend_js

import arpx.audio.UrlAudio;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.audio.AudioContext;
import arpx.impl.cross.audio.IAudioImpl;
import js.html.audio.AudioBuffer;
import js.html.audio.AudioBufferSourceNode;
import js.html.XMLHttpRequest;

class UrlAudioImpl extends ArpObjectImplBase implements IAudioImpl {

	private var audio:UrlAudio;
	private var xhr:XMLHttpRequest;
	private var buffer:AudioBuffer;

	public function new(audio:UrlAudio) {
		super();
		this.audio = audio;
	}

	override public function arpHeatUp():Bool {
		if (xhr != null) return this.audio != null;

		this.xhr = new XMLHttpRequest();
		xhr.open("GET", this.audio.src, true);
		xhr.responseType = untyped "arraybuffer";
		xhr.onload = this.onLoaded;
		xhr.onerror = this.onError;
		this.audio.arpDomain.waitFor(this.audio);
		xhr.send();
		return false;
	}

	private function onLoaded():Void {
		var contextImpl:AudioContextImpl = AudioContext.instance.impl;
		contextImpl.decodeAudioData(xhr.response, this.onDecoded);
	}

	private function onDecoded(buf:Null<AudioBuffer>):Void {
		if (this.xhr != null) this.buffer = buf;
		this.audio.arpDomain.notifyFor(this.audio);
	}

	private function onError():Void {
		this.audio.arpDomain.notifyFor(this.audio);
	}

	override public function arpHeatDown():Bool {
		if (this.buffer == null) return true;
		this.xhr.onload = null;
		this.xhr.onerror = null;
		this.xhr = null;
		this.buffer = null;
		return true;
	}

	public function play(context:AudioContext):Void {
		var nativeContext:js.html.audio.AudioContext = context.impl.raw;
		var source:AudioBufferSourceNode = nativeContext.createBufferSource();
		source.buffer = this.buffer;
		source.connect(nativeContext.destination);
		source.start();
	}
}

#end