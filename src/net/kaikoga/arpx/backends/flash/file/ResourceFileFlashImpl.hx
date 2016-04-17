package net.kaikoga.arpx.backends.flash.file;

import net.kaikoga.arp.io.InputWrapper;
import net.kaikoga.arp.io.IInput;
import haxe.io.BytesInput;
import haxe.io.Bytes;
import haxe.Resource;
import net.kaikoga.arpx.file.ResourceFile;

class ResourceFileFlashImpl implements IFileFlashImpl {

	private var file:ResourceFile;

	public function new(file:ResourceFile) {
		this.file = file;
	}

	public function bytes():Bytes {
		return Resource.getBytes(file.src);
	}

	public function read():IInput {
		return new InputWrapper(new BytesInput(Resource.getBytes(file.src)));
	}
}


