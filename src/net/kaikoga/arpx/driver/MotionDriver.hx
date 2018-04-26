package net.kaikoga.arpx.driver;

import net.kaikoga.arp.ds.impl.VoidSet;
import net.kaikoga.arp.ds.ISet;
import net.kaikoga.arpx.hitFrame.HitFrame;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.mortal.Mortal;
import net.kaikoga.arpx.motion.Motion;
import net.kaikoga.arpx.motionFrame.MotionFrame;
import net.kaikoga.arpx.motionSet.MotionSet;
import net.kaikoga.arpx.reactFrame.ReactFrame;

@:arpType("driver", "motion")
class MotionDriver extends Driver {

	@:arpField public var motionSpeed:Float = 1;
	@:arpBarrier @:arpField public var motionSet:MotionSet;
	@:arpField(false) public var nowMotion:Motion;
	@:arpField public var nowTime:Float;
	@:arpField(false) public var nowMotionFrame:MotionFrame;

	@:arpField public var dHitType:String;
	@:arpField private var willReact:Bool;

	@:arpHeatUp
	private function heatUp():Bool {
		// FIXME
		// if (this.motionSet != null) this.startMotion(this.motionSet.initMotion);
		this.nowMotion = this.motionSet.initMotion;
		this.nowTime = 0;
		this.nowMotionFrame = this.nowMotion.motionFrames.first();
		return true;
	}

	public function new() {
		super();
	}

	private function setFrame(mortal:Mortal, motionFrame:MotionFrame = null):Void {
		if (motionFrame == null) return;
		this.nowMotionFrame = motionFrame;
		mortal.params.merge(motionFrame.params);
	}

	private function hitFrames():ISet<HitFrame> {
		if (this.nowMotionFrame == null) return new VoidSet();
		return this.nowMotionFrame.hitFrames;
	}

	private function startMotion(mortal:Mortal, motion:Motion = null):Void {
		if (motion == null) return;
		this.nowMotion = motion;
		this.nowTime = 0;
		this.setFrame(mortal, motion.motionFrames.first());
	}

	override public function startAction(mortal:Mortal, actionName:String, restart:Bool = false):Bool {
		var newMotion:Motion;
		newMotion = this.nowMotion.nextMotion(actionName, this.nowTime);
		if (newMotion == null) {
			newMotion = this.motionSet.nextMotion(actionName, this.nowTime);
		}
		if (newMotion == null) {
			return false;
		}
		if (restart || (this.nowMotion != newMotion)) {
			this.startMotion(mortal, newMotion);
			mortal.onStartAction(actionName, newMotion);
		}
		return true;
	}

	@:access(net.kaikoga.arpx.field.Field.hitField)
	override public function tick(field:Field, mortal:Mortal):Void {
		var nowMotion:Motion = this.nowMotion;
		if (nowMotion != null) {
			var oldTime:Float = this.nowTime;
			var newTime:Float = this.nowTime + this.motionSpeed;
			var time:Float;

			var motionFrame:MotionFrame = null;
			var moved:Bool = false;
			for (frame in this.nowMotion.motionFrames) {
				time = frame.time;
				if (time < oldTime) {
					// last frame has already been ended
					motionFrame = frame;
					continue;
				} else if (time < newTime) {
					// last frame has just ended
					if (motionFrame != null) {
						motionFrame.updateMortalPosition(field, mortal, oldTime, time, this.dHitType);
					}
					oldTime = time;
					motionFrame = frame;
				} else {
					// last frame has not ended
					break;
				}
			}
			if (motionFrame != null) {
				// cleanup current motion frame
				motionFrame.updateMortalPosition(field, mortal, oldTime, newTime, this.dHitType);
			} else {
				// movement did not occur
				mortal.stayWithHit(field, this.dHitType);
			}

			if (this.willReact) {
				for (reactFrame in this.nowMotion.reactFrames) {
					time = reactFrame.time;

					if (time + reactFrame.duration < newTime) {
						// reaction range has just ended
					} else if (time < newTime) {
						if (oldTime <= time) {
							// reaction has just started
							field.dispatchReactFrame(mortal, reactFrame, 0);
						} else {
							// reaction range has been started
							field.dispatchReactFrame(mortal, reactFrame, newTime - time);
						}
					} else {
						// reaction range has not started
					}
				}
			}

			if (newTime >= nowMotion.time) {
				if (!this.startAction(mortal, nowMotion.loopAction, true)) {
					this.startMotion(mortal, nowMotion);
				}
				var reactFrame:ReactFrame = this.nowMotion.reactFrames.first();
				if (reactFrame != null) {
					field.dispatchReactFrame(mortal, reactFrame, 0);
				}
			} else {
				this.nowTime = newTime;
				this.setFrame(mortal, motionFrame);
			}
		}
		super.tick(field, mortal);
	}
}
