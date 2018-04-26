package net.kaikoga.arpx.backends.flash.fieldGizmo;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.geom.ITransform;

interface IFieldGizmoFlashImpl extends IArpObjectImpl {

	function render(field:Field, bitmapData:BitmapData, transform:ITransform):Void;

}

#end
