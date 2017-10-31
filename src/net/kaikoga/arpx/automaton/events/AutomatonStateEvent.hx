package net.kaikoga.arpx.automaton.events;

import net.kaikoga.arp.ds.IList;
import net.kaikoga.arpx.state.AutomatonState;

class AutomatonStateEvent extends AutomatonEvent<AutomatonStateEventKind> {

	public var payload:Dynamic;

	public function new(kind:AutomatonStateEventKind, stateStack:IList<AutomatonState>, payload:Dynamic) {
		super(kind, stateStack);
		this.payload = payload;
	}

	override public function describe():String {
		switch (this.kind) {
			case AutomatonStateEventKind.Enter:
				return 'Enter: ${stateStackLabels.join(", ")}';
			case AutomatonStateEventKind.Leave:
				return 'Leave: ${stateStackLabels.join(", ")}';
		}
	}
}

enum AutomatonStateEventKind {
	Enter;
	Leave;
}
