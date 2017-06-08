package net.kaikoga.arpx.state;

import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arpx.automaton.Automaton;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.console.Console;

@:access(net.kaikoga.arpx.automaton.Automaton)
@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("state", "state"))
class AutomatonState implements IArpObject {

	@:arpField public var label:String;
	@:arpField public var originalState:AutomatonState;
	@:arpField("state") public var childState:AutomatonState;
	@:arpField("transition") public var transitions:IMap<String, AutomatonState>;
	@:arpField public var automaton:Automaton;

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
		var automaton:Automaton = this.arpDomain.allocObject(Automaton);
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
