package net.kaikoga.arpx.input;

import net.kaikoga.arpx.input.focus.IFocusNode;

interface IInputControl extends IFocusNode<IInputControl> {
	function interact(input:Input):Bool;
}
