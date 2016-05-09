package net.kaikoga.arpx.automaton.events;

import net.kaikoga.arp.domain.ArpSlot;
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
		var fullStateStackCapture:List<ArpSlot<AutomatonState>> = Lambda.map(
			ListOp.toArray(this.stateStack),
			function(state:AutomatonState):ArpSlot<AutomatonState> return state.originalState.arpSlot()
		);
		fullStateStackCapture.push(this.state.originalState.arpSlot());
		switch (this.kind) {
			case AutomatonStateEventKind.Enter:
				return 'Enter: ${Std.string(Lambda.array(fullStateStackCapture).toString())}';
			case AutomatonStateEventKind.Leave:
				return  'Leave: ${Std.string(Lambda.array(fullStateStackCapture).toString())}';
		}
	}
}

enum AutomatonStateEventKind {
	Enter;
	Leave;
}
