package net.kaikoga.arpx.input.decorators;

import net.kaikoga.arpx.backends.flash.input.decorators.FocusInputFlashImpl;

@:arpType("input", "focus")
class FocusInput extends Input {

	@:arpField private var input:Input;
	@:arpField private var priority:Int;
	@:arpField(false) private var focused:Bool = false;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:FocusInputFlashImpl;
#end

	public function new () super();

	override public function axis(button:String):InputAxis {
		return this.focused ? this.input.axis(button) : new InputAxis();
	}

	override public function findFocus(other:Null<Input>):Null<Input> {
		if (other == null) return this;
		if (Std.is(other, FocusInput)) {
			if (cast(other, FocusInput).priority < this.priority) return this;
		}
		return other;
	}

	override public function updateFocus(target:Null<Input>):Void this.focused = this == target;
}
