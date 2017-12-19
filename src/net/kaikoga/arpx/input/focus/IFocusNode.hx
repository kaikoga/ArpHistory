package net.kaikoga.arpx.input.focus;

@:noDoc @:noCompletion
interface IFocusNode<T> {
	function visitFocus(other:Null<T>):Null<T>;
}
