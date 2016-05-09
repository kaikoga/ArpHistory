package net.kaikoga.arpx.automaton.events;

import net.kaikoga.arpx.state.AutomatonState;

class AutomatonTransitionEvent extends AutomatonEvent<AutomatonTransitionEventKind> {

	public var oldState:AutomatonState;
	public var newStateTemplate:AutomatonState;
	public var key:String;
	public var payload:Dynamic;

	public function new(kind:AutomatonTransitionEventKind, oldState:AutomatonState, newStateTemplate:AutomatonState, key:String, payload:Dynamic) {
		super(kind);
		this.oldState = oldState;
		this.newStateTemplate = newStateTemplate;
		this.key = key;
		this.payload = payload;
	}

	override public function describe():String {
		switch (this.kind) {
			case AutomatonTransitionEventKind.Transition:
				return 'Transition: ${oldState.originalState.arpSlot()} -> ${key} -> ${newStateTemplate.arpSlot()}';
		}
	}
}

enum AutomatonTransitionEventKind {
	Transition;
}
