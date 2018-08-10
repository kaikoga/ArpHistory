package arpx.impl.flash.audio;

#if (arp_audio_backend_flash || arp_audio_backend_openfl)

import flash.utils.ByteArray;
import flash.media.Sound;
import haxe.io.Bytes;
import haxe.Resource;
import arpx.audio.ResourceAudio;

class ResourceAudioImpl extends ArpObjectImplBase implements IAudioImpl {

	private var audio:ResourceAudio;
	private var value:Sound;

	public function new(audio:ResourceAudio) {
		super();
		this.audio = audio;
	}

	override public function arpHeatUp():Bool {
		if (this.value != null) return true;

		var bytes:Bytes = Resource.getBytes(audio.src);
		this.value = new Sound();
		var byteArray:ByteArray = bytes.getData();
		byteArray.position = 0;
		this.value.loadCompressedDataFromByteArray(byteArray, byteArray.length);
		return true;
	}

	override public function arpHeatDown():Bool {
		this.value = null;
		return true;
	}

	public function play():Void {
		this.value.play(0, 1);
	}
}

#end