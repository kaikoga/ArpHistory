package net.kaikoga.arpx.motion;

import net.kaikoga.arpx.reactFrame.ReactFrame;
import net.kaikoga.arpx.motionFrame.MotionFrame;
import net.kaikoga.arp.ds.IList;
import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arpx.nextMotion.NextMotion;
import net.kaikoga.arp.domain.IArpObject;

@:arpType("motion", "motion")
class Motion implements IArpObject {

	@:arpBarrier @:arpField("motion") public var motions:IMap<String, Motion>;
	@:arpField public var time:Float;
	@:arpBarrier @:arpField("nextMotion") public var nextMotions:IList<NextMotion>;
	@:arpField public var loopAction:String;
	@:arpBarrier @:arpField("motionFrame") public var motionFrames:IList<MotionFrame>;
	@:arpBarrier @:arpField("reactFrame") public var reactFrames:IList<ReactFrame>;

	public function new() {
	}

	public function nextMotion(actionName:String, time:Float):Motion {
		for (nextMotion in this.nextMotions) {
			if (nextMotion.timeRange.hasValue && !nextMotion.timeRange.contains(time)) continue;
			if (actionName == nextMotion.action) {
				return nextMotion.motion;
			}
		}
		return this.motions.get(actionName);
	}
}


