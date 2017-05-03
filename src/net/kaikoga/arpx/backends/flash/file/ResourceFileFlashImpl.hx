package net.kaikoga.arpx.backends.flash.file;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arp.io.InputWrapper;
import net.kaikoga.arp.io.IInput;
import haxe.io.BytesInput;
import haxe.io.Bytes;
import haxe.Resource;
import net.kaikoga.arpx.file.ResourceFile;

class ResourceFileFlashImpl extends ArpObjectImplBase implements IFileFlashImpl {

	private var file:ResourceFile;

	public function new(file:ResourceFile) {
		super();
		this.file = file;
	}

	public var exists(get, never):Bool;
	private function get_exists():Bool {
		// TODO optimize resource handling
		return Resource.listNames().indexOf(file.src) >= 0;
	}

	public function bytes():Bytes {
		return Resource.getBytes(file.src);
	}

	public function read():IInput {
		return new InputWrapper(new BytesInput(Resource.getBytes(file.src)));
	}
}

