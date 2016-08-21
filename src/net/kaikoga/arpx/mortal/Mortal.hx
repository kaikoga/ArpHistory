package net.kaikoga.arpx.mortal;

import net.kaikoga.arpx.motion.Motion;
import net.kaikoga.arpx.driver.Driver;
import net.kaikoga.arp.domain.ArpDirectory;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.hitFrame.HitFrame;
import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.reactFrame.ReactFrame;

#if arp_backend_flash
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.backends.flash.geom.APoint;
import net.kaikoga.arpx.backends.flash.mortal.IMortalFlashImpl;
import flash.display.BitmapData;
#end

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("mortal", "null"))
class Mortal implements IArpObject
#if arp_backend_flash implements IMortalFlashImpl #end
{

	@:arpBarrier @:arpField public var driver:Driver;
	@:arpField public var position:ArpPosition;
	@:arpField public var visible:Bool = true;
	@:arpField public var params:ArpParams;
	@:arpBarrier @:arpField("hitFrame") public var hitFrames:IOmap<String, HitFrame>;
	@:arpField(false) public var lastReactions:IOmap<String, Int>;

	#if arp_backend_flash

	private var flashImpl:IMortalFlashImpl;

	private function createImpl():IMortalFlashImpl return null;

	public function new() {
		flashImpl = createImpl();
	}

	inline public function copySelf(bitmapData:BitmapData, transform:ITransform):Void {
		flashImpl.copySelf(bitmapData, transform);
	}

	#else

	@:arpWithoutBackend
	public function new () {
	}

	#end


	public function collidesPosition(position:ArpPosition, hitType:String):Bool {
		var hitFrame:HitFrame = this.hitFrames.get(hitType);
		return (hitFrame != null) ? hitFrame.collidesPosition(this.position, position) : false;
	}

	public function collidesCoordinate(x:Float, y:Float, z:Float, hitType:String):Bool {
		var hitFrame:HitFrame = this.hitFrames.get(hitType);
		return (hitFrame != null) ? hitFrame.collidesCoordinate(this.position, x, y, z) : false;
	}

	public function collidesMortal(mortal:Mortal, hitType:String):Bool {
		var hitFrame:HitFrame = this.hitFrames.get(hitType);
		return (hitFrame != null) ? hitFrame.collidesHitFrame(this.position, mortal.position, mortal.hitFrames.get(hitType)) : false;
	}

	private static var _workPt:APoint = new APoint();

	public function tick(field:Field):Void {
		if (this.driver != null) this.driver.tick(field, this);

		if (this.lastReactions.length == 0) {
			return;
		}
		for (name in this.lastReactions.keys()) {
			switch (this.lastReactions.get(name)) {
				case 0:
					this.lastReactions.removeKey(name);
				case 1:
					this.lastReactions.addPair(name, 0);
			}
		}
	}

	public function startAction(actionName:String, restart:Bool = false):Bool {
		return this.driver.startAction(this, actionName, restart);
	}

	public function onStartAction(actionName:String, newMotion:Motion):Void {

	}

	public function react(field:Field, source:Mortal, reactFrame:ReactFrame, delay:Float):Void {
		var reactionName:String = source.arpSlot().sid + ArpDirectory.PATH_DELIMITER + reactFrame.arpSlot().sid;
		if (delay != 0 && !reactFrame.hold && this.lastReactions.hasKey(reactionName)) {
			this.lastReactions.addPair(reactionName, 1);
			return;
		}
		this.lastReactions.addPair(reactionName, 1);
		this.onReact(field, source, reactFrame, delay);
	}

	public function onReact(field:Field, source:Mortal, reactFrame:ReactFrame, delay:Float):Void {

	}

	public function collide(field:Field, source:Mortal):Void {
		var reactionName:String = source.arpSlot().sid.toString();
		if (this.lastReactions.hasKey(reactionName)) {
			this.lastReactions.addPair(reactionName, 1);
			return;
		}
		this.lastReactions.addPair(reactionName, 1);
		this.onCollide(field, source);
	}

	public function onCollide(field:Field, source:Mortal):Void {

	}

}


