package net.kaikoga.arpx.menu;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.backends.flash.menu.IMenuFlashImpl;

@:arpType("menu", "null")
class Menu implements IArpObject
#if (arp_backend_flash || arp_backend_openfl) implements IMenuFlashImpl #end
{
	@:arpField public var visible:Bool = true;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:IMenuFlashImpl;
	#else
	@:arpWithoutBackend
	#end
	public function new() {
	}

	public var value(get, set):Int;
	private function get_value():Int return 0;
	private function set_value(value:Int):Int return value;

	public function selection():String return "";

	public function visitFocus(other:Null<Menu>):Null<Menu> return other;
	public function setFocus():Void return;
}


