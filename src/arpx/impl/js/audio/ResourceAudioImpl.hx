package arpx.impl.js.audio;

#if arp_audio_backend_js

import arpx.audio.ResourceAudio;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.audio.IAudioImpl;

class ResourceAudioImpl extends ArpObjectImplBase implements IAudioImpl {

	private var audio:ResourceAudio;

	public function new(audio:ResourceAudio) {
		super();
		this.audio = audio;
	}

	override public function arpHeatUp():Bool {
		// TODO
		return true;
	}

	override public function arpHeatDown():Bool {
		// TODO
		return true;
	}

	public function play():Void {
		// TODO
	}
}

#end
