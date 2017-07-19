package net.kaikoga.arpx.backends.flash.fieldGizmo;

import net.kaikoga.arpx.field.Field;
import flash.display.BitmapData;
import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.backends.flash.geom.ITransform;

interface IFieldGizmoFlashImpl extends IArpObjectImpl {

	function render(field:Field, bitmapData:BitmapData, transform:ITransform):Void;

}


