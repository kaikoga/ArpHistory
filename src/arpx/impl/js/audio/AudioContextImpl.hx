package arpx.impl.js.audio;

#if arp_audio_backend_js

import js.html.audio.AudioBuffer;
import js.Browser;
import js.html.audio.AudioContext;

class AudioContextImpl {

	public var raw(default, null):AudioContext;
	public var dummyBuffer(default, null):AudioBuffer;

	public function new() {
		this.raw = new AudioContext();
		this.dummyBuffer = this.raw.createBuffer(1, 1, 44100);

		// magic for iOS browser
		Browser.document.addEventListener("touchend", function() {
			var source = this.raw.createBufferSource();
			source.buffer = dummyBuffer;
			source.connect(this.raw.destination);
			source.start();
		});
	}
}

#end
