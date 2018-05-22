package net.kaikoga.arpx.automaton.procs;

import net.kaikoga.arpx.automaton.Automaton;
import net.kaikoga.arpx.proc.Proc;
import net.kaikoga.arpx.structs.ArpParams;

@:arpType("proc", "automaton.transition")
class ProcAutomatonTransition extends Proc {
	@:arpField public var automaton:Automaton;
	@:arpField public var transitionKey:String;
	@:arpField public var params:ArpParams;

	public function new() {
		super();
	}

	override public function execute():Void {
		automaton.transition(transitionKey, params);
	}
}
