package net.kaikoga.arpx.fieldGizmo;

import net.kaikoga.arpx.mortal.Mortal.HitMortal;
import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arp.structs.ArpColor;

import net.kaikoga.arpx.impl.cross.fieldGizmo.HitMortalFieldGizmoImpl;

@:arpType("fieldGizmo", "hitMortal")
class HitMortalFieldGizmo extends FieldGizmo
{
	@:arpField @:arpDefault("#ff99ff") public var simpleHitColor:ArpColor;
	@:arpField @:arpDefault("#99ffff") public var complexHitColor:ArpColor;

	@:arpField public var simpleHitType:IMap<String, ArpColor>;
	@:arpField public var complexHitType:IMap<String, ArpColor>;

	@:arpImpl private var arpImpl:HitMortalFieldGizmoImpl;

	public function new() super();

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
