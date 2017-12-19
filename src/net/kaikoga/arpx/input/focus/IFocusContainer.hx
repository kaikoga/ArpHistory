package net.kaikoga.arpx.input.focus;

@:noDoc @:noCompletion
interface IFocusContainer<T> extends IFocusNode<T> {
	function updateFocus():Null<T>;
}

