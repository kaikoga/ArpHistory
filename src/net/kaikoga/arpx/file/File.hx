package net.kaikoga.arpx.file;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.impl.cross.file.IFileImpl;

@:arpType("file", "null")
class File implements IFileImpl implements IArpObject {

	@:arpImpl private var flashImpl:IFileImpl;

	public function new () {
	}
}
