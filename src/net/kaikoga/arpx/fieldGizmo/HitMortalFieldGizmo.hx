package net.kaikoga.arpx.fieldGizmo;

import net.kaikoga.arpx.mortal.Mortal.HitMortal;
import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arp.structs.ArpColor;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.fieldGizmo.HitMortalFieldGizmoFlashImpl;
#end

@:arpType("fieldGizmo", "hitMortal")
class HitMortalFieldGizmo extends FieldGizmo
{
	@:arpField @:arpDefault("#ff99ff") public var simpleHitColor:ArpColor;
	@:arpField @:arpDefault("#99ffff") public var complexHitColor:ArpColor;

	@:arpField public var simpleHitType:IMap<String, ArpColor>;
	@:arpField public var complexHitType:IMap<String, ArpColor>;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:HitMortalFieldGizmoFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new () {
		super();
	}

	public function hitColorFor(hitMortal:HitMortal):ArpColor {
		return if (hitMortal.isComplex) {
			if (complexHitType.hasKey(hitMortal.hitType)) {
				complexHitType.get(hitMortal.hitType);
			} else {
				complexHitColor;
			}
		} else {
			if (simpleHitType.hasKey(hitMortal.hitType)) {
				simpleHitType.get(hitMortal.hitType);
			} else {
				simpleHitColor;
			}
		}
	}
}
