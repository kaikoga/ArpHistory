package arpx.motion;

import arp.domain.IArpObject;
import arp.ds.IList;
import arp.ds.IMap;
import arpx.motionFrame.MotionFrame;
import arpx.nextMotion.NextMotion;
import arpx.reactFrame.ReactFrame;

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


