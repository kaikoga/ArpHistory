package net.kaikoga.arpx.screen;

import net.kaikoga.arp.ds.IList;
import net.kaikoga.arpx.impl.cross.screen.HudScreenImpl;
import net.kaikoga.arpx.hud.Hud;
import net.kaikoga.arpx.input.Input;
import net.kaikoga.arpx.camera.Camera;

@:arpType("screen", "hud")
class HudScreen extends Screen {
	@:arpBarrier @:arpField("hud") public var huds:IList<Hud>;
	@:arpField public var camera:Camera;
	@:arpField public var input:Input;
	@:arpField public var focus:Hud;

	@:arpImpl private var arpImpl:HudScreenImpl;

	override public function set_visible(value:Bool):Bool {
		if (super.visible && !value) this.input.updateFocus(null);
		return super.set_visible(value);
	}

	public function new() super();

	override public function tick(timeslice:Float):Bool {
		if (this.visible) {
			var other:Null<Hud> = this.focus;
			if (other == null && this.input != null) {
				for (hud in this.huds) other = hud.findFocus(other);
			}
			for (hud in this.huds) hud.updateFocus(other);
			if (other != null && this.input != null) other.interact(this.input);
		}
		return true;
	}

	override public function findFocus(other:Null<Input>):Null<Input> {
		return if (this.visible && this.input != null) input.findFocus(other) else other;
	}

	override public function updateFocus(target:Null<Input>):Void {
		if (this.visible && this.input != null) input.updateFocus(target);
	}
}
