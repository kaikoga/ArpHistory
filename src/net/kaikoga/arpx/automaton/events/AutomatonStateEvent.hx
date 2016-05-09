package net.kaikoga.arpx.automaton.events;

import net.kaikoga.arp.ds.lambda.ListOp;
import net.kaikoga.arp.ds.IList;
import net.kaikoga.arpx.state.AutomatonState;

class AutomatonStateEvent extends AutomatonEvent<AutomatonStateEventKind> {

	public var state:AutomatonState;
	public var stateStack:IList<AutomatonState>;
	public var payload:Dynamic;

	public function new(kind:AutomatonStateEventKind, state:AutomatonState, stateStack:IList<AutomatonState>, payload:Dynamic) {
		super(kind);
		this.state = state;
		this.stateStack = stateStack;
		this.payload = payload;
	}

	override public function describe():String {
		var fullStateStackCapture:List<String> = Lambda.map(
			ListOp.toArray(this.stateStack),
			function(state:AutomatonState):String return state.label
		);
		fullStateStackCapture.push(this.state.label);
		switch (this.kind) {
			case AutomatonStateEventKind.Enter:
				return 'Enter: ${Lambda.array(fullStateStackCapture).join(", ")}';
			case AutomatonStateEventKind.Leave:
				return  'Leave: ${Lambda.array(fullStateStackCapture).join(", ")}';
		}
	}
}

enum AutomatonStateEventKind {
	Enter;
	Leave;
}
