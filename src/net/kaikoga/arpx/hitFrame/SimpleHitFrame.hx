package net.kaikoga.arpx.hitFrame;

import net.kaikoga.arp.structs.ArpHitArea;
import net.kaikoga.arp.structs.ArpPosition;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("hitFrame", "simple"))
class SimpleHitFrame extends HitFrame {

	@:arpField public var hitArea:ArpHitArea;

	public function new() {
		super();
	}

	override public function collidesPosition(base:ArpPosition, position:ArpPosition):Bool {
		return this.hitArea.collidesPosition(base, position);
	}

	override public function collidesCoordinate(base:ArpPosition, x:Float, y:Float, z:Float):Bool {
		return this.hitArea.collidesCoordinate(base, x, y, z);
	}

	override public function collidesHitFrame(base:ArpPosition, targetBase:ArpPosition, target:HitFrame):Bool {
		var tframe:SimpleHitFrame = try cast(target, SimpleHitFrame) catch (e:Dynamic) null;
		if (tframe != null) {
			return this.hitArea.collidesHitArea(base, targetBase, tframe.hitArea);
		}
		return false;
	}

	override public function mapTo(base:ArpPosition, targetBase:ArpPosition, target:HitFrame, input:ArpPosition, output:ArpPosition = null):ArpPosition {
		var tframe:SimpleHitFrame = try cast(target, SimpleHitFrame) catch (e:Dynamic) null;
		if (tframe != null) {
			var tarea:ArpHitArea = tframe.hitArea;
			if (output == null) output = new ArpPosition(targetBase.x, targetBase.y, targetBase.z, input.dir.value);
			var areaWidth:Float = this.hitArea.width;
			if (areaWidth > 0) {
				output.x += (input.x - base.x - this.hitArea.areaLeft) / areaWidth * tarea.width + tarea.areaLeft;
			}
			var areaHeight:Float = this.hitArea.height;
			if (areaHeight > 0) {
				output.y += (input.y - base.y - this.hitArea.areaTop) / areaHeight * tarea.height + tarea.areaTop;
			}
			var areaDepth:Float = this.hitArea.depth;
			if (areaDepth > 0) {
				output.x += (input.z - base.z - this.hitArea.areaHind) / areaDepth * tarea.depth + tarea.areaHind;
			}
			return output;
		}
		return null;
	}
}


