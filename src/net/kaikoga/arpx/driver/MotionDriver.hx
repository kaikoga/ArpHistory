package net.kaikoga.arpx.driver;

import net.kaikoga.arpx.field.Field;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.hitFrame.HitFrame;
import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arp.ds.impl.VoidOmap;
import net.kaikoga.arpx.motion.Motion;
import net.kaikoga.arpx.reactFrame.ReactFrame;
import net.kaikoga.arpx.motionFrame.MotionFrame;
import net.kaikoga.arpx.mortal.Mortal;
import net.kaikoga.arpx.motionSet.MotionSet;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("driver", "motion"))
class MotionDriver extends Driver {

	@:arpField public var motionSpeed:Float = 1;
	@:arpField public var motionSet:MotionSet;
	@:arpField public var nowMotion:Motion;
	@:arpField public var nowTime:Float;
	@:arpField public var nowMotionFrame:MotionFrame;

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

	private function hitFrames():IOmap<String, HitFrame> {
		if (this.nowMotionFrame == null) return new VoidOmap();
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

	override public function tick(field:Field, mortal:Mortal):Void {
		var nowMotion:Motion = this.nowMotion;
		if (nowMotion != null) {
			var oldTime:Float = this.nowTime;
			var newTime:Float = this.nowTime + this.motionSpeed;
			var time:Float;

			var motionFrame:MotionFrame = null;
			for (frame in this.nowMotion.motionFrames) {
				time = frame.time;
				if (time < oldTime) {
					// last frame has already been ended
					motionFrame = frame;
					continue;
				} else if (time < newTime) {
					// last frame has just ended
					if (motionFrame != null) {
						motionFrame.updateMortalPosition(field, mortal, oldTime, time);
					}
					oldTime = time;
					motionFrame = frame;
				} else {
					// last frame has not ended
					break;
				}
			}
			// cleanup current motion frame
			if (motionFrame != null) {
				motionFrame.updateMortalPosition(field, mortal, oldTime, newTime);
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
