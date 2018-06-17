package arpx.impl.heaps.audio;

#if arp_audio_backend_heaps

import haxe.Resource;
import haxe.io.Bytes;
import hxd.fs.BytesFileSystem.BytesFileEntry;
import hxd.fs.FileEntry;
import hxd.res.Sound;
import arpx.audio.ResourceAudio;
import arpx.impl.ArpObjectImplBase;

class ResourceAudioHeapsImpl extends ArpObjectImplBase implements IAudioHeapsImpl {

	private var audio:ResourceAudio;
	private var value:Sound;

	public function new(audio:ResourceAudio) {
		super();
		this.audio = audio;
	}

	override public function arpHeatUp():Bool {
		if (value != null) return true;
		var bytes:Bytes = Resource.getBytes(audio.src);
		var fileEntry:FileEntry = new BytesFileEntry("", bytes);

		this.value = new Sound(fileEntry);
		return true;
	}

	override public function arpHeatDown():Bool {
		this.value.dispose();
		this.value = null;
		return true;
	}

	public function play():Void {
		this.value.play();
	}
}

#end
