package arpx.impl.flash.audio;

#if arp_audio_backend_flash

import arpx.impl.cross.audio.AudioContext;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.media.Sound;
import flash.net.URLRequest;

import arpx.audio.UrlAudio;
import arpx.impl.cross.audio.IAudioImpl;

class UrlAudioImpl extends ArpObjectImplBase implements IAudioImpl {

	private var audio:UrlAudio;
	private var value:Sound;
	private var loadingValue:Sound;

	public function new(audio:UrlAudio) {
		super();
		this.audio = audio;
	}

	override public function arpHeatUp():Bool {
		if (this.loadingValue != null) return this.value != null;

		this.loadingValue = new Sound();
		this.loadingValue.addEventListener(Event.COMPLETE, this.onLoadComplete);
		this.loadingValue.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadError);
		this.loadingValue.load(new URLRequest(this.audio.src));
		this.audio.arpDomain.waitFor(this.audio);
		return false;
	}

	private function onLoadComplete(event:Event):Void {
		this.value = this.loadingValue;
		this.audio.arpDomain.notifyFor(this.audio);
	}

	private function onLoadError(event:IOErrorEvent):Void {
		this.audio.arpDomain.notifyFor(this.audio);
	}

	override public function arpHeatDown():Bool {
		if (this.loadingValue == null) return true;

		this.value = null;
		this.loadingValue = null;
		this.loadingValue.removeEventListener(Event.COMPLETE, this.onLoadComplete);
		this.loadingValue.removeEventListener(IOErrorEvent.IO_ERROR, this.onLoadError);
		return true;
	}

	public function play(context:AudioContext):Void {
		this.value.play(0, 1);
	}
}

#end