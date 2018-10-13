package arpx.impl.js.audio;

#if arp_audio_backend_js

import arpx.audio.ResourceAudio;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.audio.AudioContext;
import arpx.impl.cross.audio.IAudioImpl;
import haxe.io.Bytes;
import haxe.Resource;
import js.html.audio.AudioBuffer;
import js.html.audio.AudioBufferSourceNode;

class ResourceAudioImpl extends ArpObjectImplBase implements IAudioImpl {

	private var audio:ResourceAudio;
	private var buffer:AudioBuffer;

	private static var _dummyBuffer:AudioBuffer;
	private static var dummyBuffer(get, never):AudioBuffer;
	private static function get_dummyBuffer():AudioBuffer return if (_dummyBuffer != null) _dummyBuffer else _dummyBuffer = AudioContext.instance.impl.raw.createBuffer(1, 1, 44100);

	public function new(audio:ResourceAudio) {
		super();
		this.audio = audio;
	}

	override public function arpHeatUp():Bool {
		var nativeContext:js.html.audio.AudioContext = AudioContext.instance.impl.raw;
		var bytes:Bytes = Resource.getBytes(this.audio.src);
		this.buffer = dummyBuffer;
		nativeContext.decodeAudioData(
			bytes.getData(),
			function(buf) {
				if (this.buffer == dummyBuffer) this.buffer = buf;
				this.audio.arpDomain.notifyFor(this.audio);
			},
			function() this.audio.arpDomain.notifyFor(this.audio)
		);
		this.audio.arpDomain.waitFor(this.audio);
		return false;
	}

	override public function arpHeatDown():Bool {
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
