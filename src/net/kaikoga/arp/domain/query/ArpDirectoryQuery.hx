package net.kaikoga.arp.domain.query;

import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
import net.kaikoga.arp.domain.core.ArpType;

class ArpDirectoryQuery {

	inline public static var PATH_DELIMITER:String = "/";

	private var root:ArpDirectory;
	private var path:String;
	private var pathArray:Array<String> = null;

	inline public function new(root:ArpDirectory, path:String = null) {
		if (path == null) path = "";
		if (path.charAt(0) == PATH_DELIMITER) {
			//absolute path
			root = root.domain.root;
			path = path.substr(1);
		}
		this.root = root;
		this.path = path;
		if (path.indexOf(PATH_DELIMITER) >= 0) {
			this.pathArray = path.split(PATH_DELIMITER);
		}
	}

	inline public function directory():ArpDirectory {
		if (this.path == null) return this.root; 
		if (this.pathArray == null) return this.root.child(this.path);
		var slot:ArpDirectory = this.root;
		for (element in this.pathArray) slot = slot.child(element);
		return slot;
	}

	inline public function link(dir:ArpDirectory):ArpDirectory {
		var target:ArpDirectory = this.directory();
		target.linkTo(dir);
		return dir;
	}

}
