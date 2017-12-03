package net.kaikoga.arpx.state;

import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arpx.automaton.Automaton;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.screen.Screen;

@:access(net.kaikoga.arpx.automaton.Automaton)
@:arpType("state", "state")
class AutomatonState implements IArpObject {

	@:arpField public var label:String;
	@:arpField("state") public var childState:AutomatonState;
	@:arpField("transition") public var transitions:IMap<String, AutomatonState>;

	public function new() return;

	public function getTransition(key:String, payload:Dynamic = null):Null<AutomatonState> return this.transitions.get(key);

	@:allow(net.kaikoga.arpx.automaton.Automaton)
	private function enterState(automaton:Automaton, payload:Dynamic = null):Void onEnterState(automaton, payload);
	@:allow(net.kaikoga.arpx.automaton.Automaton)
	private function leaveState(automaton:Automaton, payload:Dynamic = null):Void onLeaveState(automaton, payload);

	public function onEnterState(automaton:Automaton, payload:Dynamic = null):Void return;
	public function onLeaveState(automaton:Automaton, payload:Dynamic = null):Void return;

	public function toAutomaton():Automaton {
		var automaton:Automaton = this.arpDomain.allocObject(Automaton);
		automaton.enterState(this);
		return automaton;
	}

	public function toScreen():Screen return null;
}
