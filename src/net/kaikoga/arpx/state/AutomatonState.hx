package net.kaikoga.arpx.state;

import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arpx.automaton.Automaton;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.console.Console;

@:access(net.kaikoga.arpx.automaton.Automaton)
@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("state", "state"))
class AutomatonState implements IArpObject {

	@:arpType("state") public var originalState:AutomatonState;
	@:arpType("state") @:arpField("state") public var childState:AutomatonState;
	@:arpType("state") @:arpField("transition") public var transitions:IMap<String, AutomatonState>;
	@:arpType("automaton") public var automaton:Automaton;

	public function new() {
	}

	public function getTransition(key:String, payload:Dynamic = null):Null<AutomatonState> {
		return this.transitions.get(key);
	}

	public function onEnterState(payload:Dynamic = null):Void {
	}

	public function onLeaveState(payload:Dynamic = null):Void {
	}

	public function toAutomaton():Automaton {
		var automaton:Automaton = new Automaton();
		this.arpDomain().addObject(automaton);
		automaton.enterState(this);
		return automaton;
	}

	public function toConsole():Console {
		return null;
	}

	public function transition(key:String, payload:Dynamic = null):Bool {
		if (this.automaton == null) return false;
		return this.automaton.transition(key, payload);
	}

}
