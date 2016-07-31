package net.kaikoga.arpx.motionFrame;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arpx.hitFrame.HitFrame;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.mortal.Mortal;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("motionFrame", "motionFrame"))
class MotionFrame implements IArpObject {

	@:arpField public var params:ArpParams;
	@:arpField("hitFrame") public var hitFrames:IOmap<String, HitFrame>;
	@:arpField public var time:Float;
	@:arpField public var dHitType:String;
	@:arpField public var dX:Float;
	@:arpField public var dY:Float;
	@:arpField public var dZ:Float;
	@:arpField public var dR:Float;
	@:arpField public var dS:Float;
	@:arpField public var ddX:Float;
	@:arpField public var ddY:Float;
	@:arpField public var ddZ:Float;
	@:arpField public var ddR:Float;
	@:arpField public var ddS:Float;

	public function new() {
	}

	public function updateShadowPosition(shadow:Mortal, oldTime:Float, newTime:Float):Void {
		var factor:Float = newTime - oldTime;
		var pos:ArpPosition = shadow.position;
		var dX:Float = this.dX + this.dR * Math.cos(pos.dir.valueRadian) + this.dS * Math.sin(pos.dir.valueRadian);
		var dY:Float = this.dY + this.dR * Math.sin(pos.dir.valueRadian) - this.dS * Math.cos(pos.dir.valueRadian);
		var dZ:Float = this.dZ;
		dX *= factor;
		dY *= factor;
		dZ *= factor;
		pos.x += dX;
		pos.y += dY;
		pos.z += dZ;
	}

	public function updateMortalPosition(field:Field, mortal:Mortal, oldTime:Float, newTime:Float):Void {
		var factor:Float = newTime - oldTime;
		var pos:ArpPosition = mortal.position;
		var dX:Float = this.dX + this.dR * Math.cos(pos.dir.valueRadian) + this.dS * Math.sin(pos.dir.valueRadian);
		var dY:Float = this.dY + this.dR * Math.sin(pos.dir.valueRadian) - this.dS * Math.cos(pos.dir.valueRadian);
		var dZ:Float = this.dZ;
		dX *= factor;
		dY *= factor;
		dZ *= factor;
		var fieldObject:Dynamic;
		var fieldMortal:Mortal;
		fieldObject = field.objectAt(mortal, pos.x + dX, pos.y, pos.z, this.dHitType);
		fieldMortal = try cast(fieldObject, Mortal) catch (e:Dynamic) null;
		if (fieldMortal != null) {
			mortal.collide(field, fieldMortal);
		} else if (fieldObject != null) {

		} else {
			pos.x += dX;
		}
		fieldObject = field.objectAt(mortal, pos.x, pos.y + dY, pos.z, this.dHitType);
		fieldMortal = try cast(fieldObject, Mortal) catch (e:Dynamic) null;
		if (fieldMortal != null) {
			mortal.collide(field, fieldMortal);
		} else if (fieldObject != null) {

		} else {
			pos.y += dY;
		}
		fieldObject = field.objectAt(mortal, pos.x, pos.y, pos.z + dZ, this.dHitType);
		fieldMortal = try cast(fieldObject, Mortal) catch (e:Dynamic) null;
		if (fieldMortal != null) {
			mortal.collide(field, fieldMortal);
		} else if (fieldObject != null) {

		} else {
			pos.z += dZ;
		}
	}
}
