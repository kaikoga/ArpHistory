package net.kaikoga.arpx.backends.kha.fieldGizmo;

#if arp_backend_kha

import kha.graphics2.Graphics;
import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.geom.ITransform;

interface IFieldGizmoKhaImpl extends IArpObjectImpl {

	function render(field:Field, g2:Graphics, transform:ITransform):Void;

}

#end