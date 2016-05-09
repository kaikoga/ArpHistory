package net.kaikoga.arpx.automaton.events;

class AutomatonEvent<T> {

	public var kind:T;

	public function new(kind:T) {
		this.kind = kind;
	}

	public function describe():String return null;
}

