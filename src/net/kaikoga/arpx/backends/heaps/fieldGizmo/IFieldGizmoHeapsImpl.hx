package net.kaikoga.arpx.backends.heaps.fieldGizmo;

#if arp_backend_heaps

import h2d.Sprite;

import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.backends.heaps.math.ITransform;
import net.kaikoga.arpx.field.Field;

interface IFieldGizmoHeapsImpl extends IArpObjectImpl {

	function render(field:Field, buf:Sprite, transform:ITransform):Void;

}

#end
