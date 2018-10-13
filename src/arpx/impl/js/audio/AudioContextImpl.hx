package arpx.impl.js.audio;

#if arp_audio_backend_js

import js.html.audio.AudioContext;

class AudioContextImpl {

	public var raw(default, null):AudioContext;

	public function new() {
		this.raw = new AudioContext();
	}
}

#end
