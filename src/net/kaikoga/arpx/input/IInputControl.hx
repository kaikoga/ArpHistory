package net.kaikoga.arpx.input;

import net.kaikoga.arpx.input.focus.IFocusable;

interface IInputControl extends IFocusable<IInputControl> {
	function interact(input:Input):Bool;
}
