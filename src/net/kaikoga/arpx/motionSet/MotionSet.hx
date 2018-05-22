package net.kaikoga.arpx.motionSet;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.ds.IList;
import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arpx.motion.Motion;
import net.kaikoga.arpx.nextMotion.NextMotion;

@:arpType("motionSet", "motionSet")
class MotionSet implements IArpObject {

	@:arpBarrier @:arpField("motion") public var motions:IMap<String, Motion>;
	@:arpBarrier @:arpField("nextMotion") public var nextMotions:IList<NextMotion>;
	@:arpBarrier @:arpField public var initMotion:Motion;

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


