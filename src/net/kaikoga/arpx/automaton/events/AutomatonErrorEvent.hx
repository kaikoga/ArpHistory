package net.kaikoga.arpx.automaton.events;

import net.kaikoga.arp.ds.IList;
import net.kaikoga.arpx.state.AutomatonState;

class AutomatonErrorEvent extends AutomatonEvent<AutomatonErrorEventKind> {

	public var key:String;
	public var payload:Dynamic;

	public function new(kind:AutomatonErrorEventKind, stateStack:IList<AutomatonState>, key:String, payload:Dynamic) {
		super(kind, stateStack);
		this.key = key;
		this.payload = payload;
	}

	override public function describe():String {
		switch (this.kind) {
			case AutomatonErrorEventKind.Inactive:
				return 'Error: Automaton is not active';
			case AutomatonErrorEventKind.TransitionNotFound:
				return 'Error: ${stateStackLabels.join(", ")} -> ${key} -> No transition found';
		}
	}
}

enum AutomatonErrorEventKind {
	Inactive;
	TransitionNotFound;
}
