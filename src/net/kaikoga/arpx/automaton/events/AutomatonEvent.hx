package net.kaikoga.arpx.automaton.events;

import net.kaikoga.arp.ds.IList;
import net.kaikoga.arp.ds.impl.ArrayList;
import net.kaikoga.arp.ds.lambda.ListOp;
import net.kaikoga.arpx.state.AutomatonState;

class AutomatonEvent<T> {

	public var kind(default, null):T;
	public var stateStack(default, null):IList<AutomatonState>;

	public var state(get, never):AutomatonState;
	inline private function get_state() return stateStack.last();

	public var stateLabel(get, never):String;
	private function get_stateLabel() return (state != null) ? state.label : null;

	public var stateStackLabels(get, never):Array<String>;
	private function get_stateStackLabels():Array<String> {
		var list:ArrayList<String> = new ArrayList<String>();
		ListOp.map(this.stateStack, function(state:AutomatonState):String return state.label, list);
		return @:privateAccess list.value;
	}

	public function new(kind:T, stateStack:IList<AutomatonState>) {
		this.kind = kind;
		this.stateStack = ListOp.copy(stateStack, new ArrayList<AutomatonState>());
	}

	public function describe():String return null;
}

