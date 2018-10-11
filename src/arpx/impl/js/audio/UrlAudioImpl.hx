package arpx.impl.js.audio;

#if arp_audio_backend_js

import js.html.Audio;
import arpx.audio.UrlAudio;
import arpx.impl.cross.audio.IAudioImpl;
import arpx.impl.ArpObjectImplBase;

class UrlAudioImpl extends ArpObjectImplBase implements IAudioImpl {

	private var audio:UrlAudio;
	private var loadingValue:Audio;
	private var value:Audio;

	public function new(audio:UrlAudio) {
		super();
		this.audio = audio;
	}

	override public function arpHeatUp():Bool {
		if (loadingValue != null) return this.value != null;

		this.loadingValue = new Audio(this.audio.src);
		this.loadingValue.onloadeddata = this.onLoaded;
		this.audio.arpDomain.waitFor(this.audio);
		return false;
	}

	private function onLoaded():Void {
		this.value = this.loadingValue;
		this.audio.arpDomain.notifyFor(this.audio);
	}

	override public function arpHeatDown():Bool {
		if (this.loadingValue == null) return true;
		this.loadingValue.onloadeddata = null;
		this.loadingValue = null;
		this.value = null;
		return true;
	}

	public function play():Void {
		// TODO
		this.value.play();
	}
}

#end
