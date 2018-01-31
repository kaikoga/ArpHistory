package net.kaikoga.arpx.menu;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arpx.menuItem.MenuItem;

@:arpType("menu")
class Menu implements IArpObject {
	@:arpField public var visible:Bool = true;
	@:arpField("menuItem") public var menuItems:IOmap<String, MenuItem>;

	@:arpField public var value:Int;

	public var length(get, never):Int;
	inline private function get_length():Int return this.menuItems.length;

	public var selection(get, never):Null<MenuItem>;
	inline private function get_selection():Null<MenuItem> {
		var item:MenuItem = this.menuItems.getAt(this.value);
		return if (item != null) item else null;
	}

	public function new() {
	}
}

