package net.kaikoga.arpx.screen;

import net.kaikoga.arpx.input.Input;
import net.kaikoga.arp.ds.IOmap;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.screen.CompositeScreenFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.screen.CompositeScreenKhaImpl;
#end

#if arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.screen.CompositeScreenHeapsImpl;
#end

@:arpType("screen", "composite")
class CompositeScreen extends Screen {
	@:arpBarrier @:arpField("screen") public var screens:IOmap<String, Screen>;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:CompositeScreenFlashImpl;
	#end

	#if arp_backend_kha
	@:arpImpl private var khaImpl:CompositeScreenKhaImpl;
	#end

	#if arp_backend_heaps
	@:arpImpl private var heapsImpl:CompositeScreenHeapsImpl;
	#end

	public function new() super();

	override public function tick(timeslice:Float):Bool {
		for (screen in this.screens) screen.tick(timeslice);
		return true;
	}

	override public function findFocus(other:Null<Input>):Null<Input> {
		for (screen in this.screens) other = screen.findFocus(other);
		return other;
	}

	override public function updateFocus(target:Null<Input>):Void {
		for (screen in this.screens) screen.updateFocus(target);
	}
}
