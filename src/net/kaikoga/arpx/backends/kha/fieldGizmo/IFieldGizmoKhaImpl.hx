package net.kaikoga.arpx.backends.kha.fieldGizmo;

#if arp_backend_kha

import flash.display.BitmapData;
import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.backends.kha.math.ITransform;
import net.kaikoga.arpx.field.Field;

interface IFieldGizmoKhaImpl extends IArpObjectImpl {

	function render(field:Field, bitmapData:BitmapData, transform:ITransform):Void;

}

#end
