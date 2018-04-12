package net.kaikoga.arpx.screen;

import net.kaikoga.arpx.input.Input;
import net.kaikoga.arpx.fieldGizmo.FieldGizmo;
import net.kaikoga.arp.ds.IList;
import net.kaikoga.arpx.camera.Camera;
import net.kaikoga.arpx.field.Field;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.screen.FieldScreenFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.screen.FieldScreenKhaImpl;
#end

#if arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.screen.FieldScreenHeapsImpl;
#end

@:arpType("screen", "screen")
class FieldScreen extends Screen {
	@:arpField public var field:Field;
	@:arpBarrier @:arpField("fieldGizmo") public var fieldGizmos:IList<FieldGizmo>;
	@:arpField public var camera:Camera;
	@:arpField public var input:Input;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:FieldScreenFlashImpl;
	#end

	#if arp_backend_kha
	@:arpImpl private var khaImpl:FieldScreenKhaImpl;
	#end

	#if arp_backend_heaps
	@:arpImpl private var heapsImpl:FieldScreenHeapsImpl;
	#end

	public function new() super();

	override public function tick(timeslice:Float):Bool {
		if (ticks) field.tick(timeslice);
		return true;
	}

	override public function findFocus(other:Null<Input>):Null<Input> {
		return if (this.visible && this.input != null) this.input.findFocus(other) else other;
	}

	override public function updateFocus(target:Null<Input>):Void {
		if (this.visible && this.input != null) this.input.updateFocus(target);
	}
}
