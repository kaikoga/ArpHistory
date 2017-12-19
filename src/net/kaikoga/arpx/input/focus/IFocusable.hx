package net.kaikoga.arpx.input.focus;

@:noDoc @:noCompletion
interface IFocusable<T> extends IFocusNode<T> {
	function setFocus(value:Bool):Void;
}
