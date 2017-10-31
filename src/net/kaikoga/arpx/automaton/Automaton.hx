package net.kaikoga.arpx.automaton;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.ds.IList;
import net.kaikoga.arp.events.ArpSignal;
import net.kaikoga.arp.events.IArpSignalOut;
import net.kaikoga.arpx.automaton.events.AutomatonErrorEvent;
import net.kaikoga.arpx.automaton.events.AutomatonStateEvent;
import net.kaikoga.arpx.automaton.events.AutomatonTransitionEvent;
import net.kaikoga.arpx.state.AutomatonState;

@:arpType("automaton", "automaton")
class Automaton implements IArpObject {

	@:arpField("state") public var stateStack:IList<AutomatonState>;

	public var state(get, never):AutomatonState;
	inline private function get_state():AutomatonState return stateStack.last();

	private var _onEnterState:ArpSignal<AutomatonStateEvent>;
	public var onEnterState(get, never):IArpSignalOut<AutomatonStateEvent>;
	private function get_onEnterState():IArpSignalOut<AutomatonStateEvent> return this._onEnterState;
	private var _onLeaveState:ArpSignal<AutomatonStateEvent>;
	public var onLeaveState(get, never):IArpSignalOut<AutomatonStateEvent>;
	private function get_onLeaveState():IArpSignalOut<AutomatonStateEvent> return this._onLeaveState;
	private var _onTransition:ArpSignal<AutomatonTransitionEvent>;
	public var onTransition(get, never):IArpSignalOut<AutomatonTransitionEvent>;
	private function get_onTransition():IArpSignalOut<AutomatonTransitionEvent> return this._onTransition;
	private var _onError:ArpSignal<AutomatonErrorEvent>;
	public var onError(get, never):IArpSignalOut<AutomatonErrorEvent>;
	private function get_onError():IArpSignalOut<AutomatonErrorEvent> return this._onError;

	public function new() {
		this._onEnterState = new ArpSignal();
		this._onLeaveState = new ArpSignal();
		this._onTransition = new ArpSignal();
		this._onError = new ArpSignal();
	}

	private function pushState(newState:AutomatonState, payload:Dynamic = null):AutomatonState {
		this.stateStack.push(newState);
		newState.enterState(this, payload);
		if (this._onEnterState.willTrigger()) {
			this._onEnterState.dispatch(new AutomatonStateEvent(AutomatonStateEventKind.Enter, this.stateStack, payload));
		}
		return newState;
	}

	private function popState(payload:Dynamic = null):Void {
		var nowState:AutomatonState = this.state;
		if (nowState != null) {
			nowState.leaveState(this, payload);
			if (this._onLeaveState.willTrigger()) {
				this._onLeaveState.dispatch(new AutomatonStateEvent(AutomatonStateEventKind.Leave, this.stateStack, payload));
			}
			this.stateStack.pop();
		}
	}

	private function enterState(newStateTemplate:AutomatonState, payload:Dynamic = null):Void {
		var newState:AutomatonState = this.pushState(newStateTemplate, payload);
		var childState:AutomatonState = newState.childState;
		if (childState != null) {
			this.enterState(childState, payload);
		}
	}

	private function leaveState(oldState:AutomatonState, payload:Dynamic = null):Void {
		var index:Int = this.stateStack.indexOf(oldState);
		if (index >= 0) {
			while (this.state != oldState) this.popState(payload);
		}
		this.popState(payload);
	}

	private function switchState(oldState:AutomatonState, newState:AutomatonState, key:String, payload:Dynamic = null):Void {
		if (this._onTransition.willTrigger()) {
			this._onTransition.dispatch(new AutomatonTransitionEvent(AutomatonTransitionEventKind.Transition, this.stateStack, oldState, newState, key, payload));
		}
		this.leaveState(oldState, payload);
		this.enterState(newState, payload);
	}

	public function transition(key:String, payload:Dynamic = null):Bool {
		var nowState:AutomatonState = this.state;
		var newState:AutomatonState;
		if (nowState == null) {
			if (this._onError.willTrigger()) {
				this._onError.dispatch(new AutomatonErrorEvent(AutomatonErrorEventKind.Inactive, this.stateStack, key, payload));
			}
			return false;
		}
		if ((newState = nowState.getTransition(key, payload)) != null) {
			this.switchState(nowState, newState, key, payload);
			return true;
		}
		var i:Int = this.stateStack.length - 1;
		while (i >= 0) {
			var parentState:AutomatonState = this.stateStack.getAt(i);
			if ((newState = parentState.getTransition(key, payload)) != null) {
				this.switchState(parentState, newState, key, payload);
				return true;
			}
			i--;
		}
		if (this._onError.willTrigger()) {
			this._onError.dispatch(new AutomatonErrorEvent(AutomatonErrorEventKind.TransitionNotFound, this.stateStack, key, payload));
		}
		return false;
	}
}
