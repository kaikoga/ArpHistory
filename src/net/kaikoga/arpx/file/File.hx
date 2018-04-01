package net.kaikoga.arpx.file;

import net.kaikoga.arpx.backends.cross.file.IFileImpl;
import net.kaikoga.arp.domain.IArpObject;

@:arpType("file", "null")
class File implements IFileImpl implements IArpObject {

	@:arpImpl private var flashImpl:IFileImpl;

	public function new () {
	}
}
