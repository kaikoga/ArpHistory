package net.kaikoga.arpx.screen;

import net.kaikoga.arp.ds.IList;
import net.kaikoga.arpx.backends.cross.screen.FieldScreenImpl;
import net.kaikoga.arpx.camera.Camera;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.fieldGizmo.FieldGizmo;
import net.kaikoga.arpx.input.Input;


@:arpType("screen", "screen")
class FieldScreen extends Screen {
	@:arpField public var field:Field;
	@:arpBarrier @:arpField("fieldGizmo") public var fieldGizmos:IList<FieldGizmo>;
	@:arpField public var camera:Camera;
	@:arpField public var input:Input;

	@:arpImpl private var arpImpl:FieldScreenImpl;

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
