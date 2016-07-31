package net.kaikoga.arpx.motionSet;

import net.kaikoga.arp.ds.IList;
import net.kaikoga.arpx.nextMotion.NextMotion;
import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.motion.Motion;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("motionSet", "motionSet"))
class MotionSet implements IArpObject {

	@:arpField("motion") public var motions:IMap<String, Motion>;
	@:arpField("nextMotion") public var nextMotions:IList<NextMotion>;
	@:arpField public var initMotion:Motion;

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


