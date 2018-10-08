package arpx.impl.stub.audio;

#if arp_audio_backend_stub

import arpx.impl.cross.audio.IAudioImpl;
import arpx.audio.ResourceAudio;

class ResourceAudioImpl extends ArpObjectImplBase implements IAudioImpl {

	private var audio:ResourceAudio;

	public function new(audio:ResourceAudio) {
		super();
		this.audio = audio;
	}

	public function play():Void return;
}

#end
