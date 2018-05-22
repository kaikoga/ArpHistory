package net.kaikoga.arpx.impl.cross.file;

import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.Resource;
import net.kaikoga.arp.io.IInput;
import net.kaikoga.arp.io.InputWrapper;
import net.kaikoga.arpx.file.ResourceFile;
import net.kaikoga.arpx.impl.ArpObjectImplBase;
import net.kaikoga.arpx.impl.cross.file.IFileImpl;

class ResourceFileImpl extends ArpObjectImplBase implements IFileImpl {

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
