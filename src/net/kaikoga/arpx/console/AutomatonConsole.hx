package net.kaikoga.arpx.console;

import net.kaikoga.arpx.automaton.events.AutomatonStateEvent;
import net.kaikoga.arpx.automaton.Automaton;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.console.AutomatonConsoleFlashImpl;
#end

@:arpType("console", "automaton")
class AutomatonConsole extends Console {

	@:arpBarrier @:arpField public var automaton:Automaton;
	@:arpField(false) private var console:Console;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:AutomatonConsoleFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new() super();

	@:arpHeatUp private function heatUp():Bool {
		this.console = this.automaton.state.toConsole();
		this.automaton.onEnterState.push(this.onEnterState);
		this.automaton.onLeaveState.push(this.onLeaveState);
		return true;
	}

	@:arpHeatDown private function heatUp():Bool {
		this.console = null;
		this.automaton.onEnterState.remove(this.onEnterState);
		this.automaton.onLeaveState.remove(this.onLeaveState);
		return true;
	}

	private function onEnterState(v:AutomatonStateEvent):Void {
		this.console = v.state.toConsole();
	}

	private function onLeaveState(v:AutomatonStateEvent):Void {
		this.console = null;
	}

	override public function tick(timeslice:Float):Bool {
		pushStack();
		this.console.tick(timeslice);
		var v:TransitionData = popStack();
		if (v != null) return this.automaton.transition(v.key, v.payload);
		return true;
	}

	private static var _transitionStack:TransitionStack;
	private static var transitionStack(get, never):TransitionStack;
	private static function get_transitionStack():TransitionStack {
		if (_transitionStack == null) _transitionStack = new TransitionStack();
		return _transitionStack;
	}

	private static function pushStack():Void transitionStack.stack.push(null);
	private static function popStack():TransitionData return transitionStack.stack.pop();

	public static function transition(key:String, payload:Dynamic = null):Void {
		var lastIndex:Int = transitionStack.stack.length - 1;
		if (lastIndex < 0) throw "invalid state";
		if (transitionStack.stack[lastIndex] != null) throw "attempt to transition twice";
		transitionStack.stack[lastIndex] = new TransitionData(key, payload);
	}
}

class TransitionStack {
	public var stack(default, null):Array<TransitionData>;
	public function new() stack = [];
}

class TransitionData {
	public var key:String;
	public var payload:Dynamic;
	public function new(key:String, payload:Dynamic) {
		this.key = key;
		this.payload = payload;
	}
}
