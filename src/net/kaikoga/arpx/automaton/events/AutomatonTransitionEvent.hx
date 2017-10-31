package net.kaikoga.arpx.automaton.events;

import net.kaikoga.arp.ds.IList;
import net.kaikoga.arpx.state.AutomatonState;

class AutomatonTransitionEvent extends AutomatonEvent<AutomatonTransitionEventKind> {

	public var oldState:AutomatonState;
	public var newState:AutomatonState;
	public var key:String;
	public var payload:Dynamic;

	public function new(kind:AutomatonTransitionEventKind, stateStack:IList<AutomatonState>, oldState:AutomatonState, newState:AutomatonState, key:String, payload:Dynamic) {
		super(kind, stateStack);
		this.oldState = oldState;
		this.newState = newState;
		this.key = key;
		this.payload = payload;
	}

	override public function describe():String {
		switch (this.kind) {
			case AutomatonTransitionEventKind.Transition:
				return 'Transition: ${oldState.label} -> ${key} -> ${newState.label}';
		}
	}
}

enum AutomatonTransitionEventKind {
	Transition;
}
