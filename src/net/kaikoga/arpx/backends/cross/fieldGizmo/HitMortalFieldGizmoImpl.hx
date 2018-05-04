package net.kaikoga.arpx.backends.cross.fieldGizmo;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.cross.fieldGizmo.IFieldGizmoImpl;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.fieldGizmo.HitMortalFieldGizmo;

class HitMortalFieldGizmoImpl extends ArpObjectImplBase implements IFieldGizmoImpl {

	private var fieldGizmo:HitMortalFieldGizmo;

	public function new(fieldGizmo:HitMortalFieldGizmo) {
		super();
		this.fieldGizmo = fieldGizmo;
	}

	public function render(field:Field, context:DisplayContext):Void {
		if (this.fieldGizmo.visible) {
			context.fillRect(0, 0, @:privateAccess field.hitField.size, 16, 0xffffffff);
			for (mortal in field.mortals) {
				for (hitMortal in @:privateAccess mortal.hitMortals) {
					var x:Int = Math.round(hitMortal.hit.x);
					var y:Int = Math.round(hitMortal.hit.y);
					var sX:Int = Math.round(hitMortal.hit.sizeX);
					var sY:Int = Math.round(hitMortal.hit.sizeY);
					var color:Int = fieldGizmo.hitColorFor(hitMortal).value32;
					context.fillRect(x - sX, y - sY, 1, sY * 2, color);
					context.fillRect(x + sX, y - sY, 1, sY * 2, color);
					context.fillRect(x - sX, y - sY, sX * 2, 1, color);
					context.fillRect(x - sX, y + sY, sX * 2, 1, color);
				}
			}
		}
	}
}
