package arpx.impl.stub.audio;

#if arp_audio_backend_stub

import arpx.audio.UrlAudio;
import arpx.impl.cross.audio.IAudioImpl;

class UrlAudioImpl extends ArpObjectImplBase implements IAudioImpl {

	private var audio:UrlAudio;

	public function new(audio:UrlAudio) {
		super();
		this.audio = audio;
	}

	public function play():Void return;
}

#end
