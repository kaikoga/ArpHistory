package net.kaikoga.arpx.reactFrame;

import net.kaikoga.arp.structs.ArpHitArea;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.hitFrame.HitFrame;
import net.kaikoga.arpx.hitFrame.SimpleHitFrame;
import net.kaikoga.arpx.mortal.Mortal;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("reactFrame"))
class ReactFrame implements IArpObject {

	@:arpField public var time:Float;
	@:arpField public var hitArea:ArpHitArea;
	@:arpField public var hitType:String;
	@:arpField public var reactType:String;
	@:arpField public var value:String;
	@:arpField public var params:ArpParams;
	@:arpField public var duration:Float;
	@:arpField public var hold:Bool;

	public function new() {
	}

	public function collidesMortal(base:ArpPosition, target:Mortal):Bool {
		return this.collidesHitFrame(base, target.position, target.hitFrames.get(this.hitType));
	}

	public function collidesHitFrame(base:ArpPosition, targetBase:ArpPosition, target:HitFrame):Bool {
		var tframe:SimpleHitFrame = try { cast(target, SimpleHitFrame); } catch (d:Dynamic) null;
		if (tframe != null) {
			return this.hitArea.collidesHitArea(base, targetBase, tframe.hitArea);
		}
		return false;
	}

}
