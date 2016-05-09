package net.kaikoga.arpx.automaton.events;

import net.kaikoga.arpx.state.AutomatonState;

class AutomatonErrorEvent extends AutomatonEvent<AutomatonErrorEventKind> {

	public var state:AutomatonState;
	public var key:String;
	public var payload:Dynamic;

	public function new(kind:AutomatonErrorEventKind, state:AutomatonState, key:String, payload:Dynamic) {
		super(kind);
		this.state = state;
		this.key = key;
		this.payload = payload;
	}

	override public function describe():String {
		switch (this.kind) {
			case AutomatonErrorEventKind.Inactive:
				return 'Error: Automaton is not active';
			case AutomatonErrorEventKind.TransitionNotFound:
				return 'Error: ${state != null ? state.label : null} -> ${key} -> No transition found';
		}
	}
}

enum AutomatonErrorEventKind {
	Inactive;
	TransitionNotFound;
}
