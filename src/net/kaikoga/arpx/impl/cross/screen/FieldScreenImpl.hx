package net.kaikoga.arpx.impl.cross.screen;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.impl.ArpObjectImplBase;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.geom.AMatrix;
import net.kaikoga.arpx.screen.FieldScreen;

class FieldScreenImpl extends ArpObjectImplBase implements IScreenImpl {

	private var screen:FieldScreen;

	public function new(screen:FieldScreen) {
		super();
		this.screen = screen;
	}

	private static var _workTransform:AMatrix = new AMatrix();
	private static var _workPos:ArpPosition = new ArpPosition();

	public function display(context:DisplayContext):Void {
		if (this.screen.field == null) return;

		var transform:AMatrix = _workTransform;
		var pos:ArpPosition = (this.screen.camera != null) ? this.screen.camera.position : _workPos;
		transform.setXY(-pos.x, -pos.y);
		context.pushTransform(transform);
		if (this.screen.visible) this.screen.field.render(context);
		for (fieldGizmo in this.screen.fieldGizmos) fieldGizmo.render(this.screen.field, context);
		context.popTransform();
	}
}
