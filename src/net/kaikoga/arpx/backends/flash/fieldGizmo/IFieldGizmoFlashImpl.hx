package net.kaikoga.arpx.backends.flash.fieldGizmo;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.field.Field;

interface IFieldGizmoFlashImpl extends IArpObjectImpl {

	function render(field:Field, bitmapData:BitmapData, transform:ITransform):Void;

}

#end
