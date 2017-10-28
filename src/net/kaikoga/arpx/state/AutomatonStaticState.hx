package net.kaikoga.arpx.state;

import net.kaikoga.arpx.automaton.Automaton;
import net.kaikoga.arpx.console.Console;

@:access(net.kaikoga.arpx.automaton.Automaton)
@:arpType("state", "static")
class AutomatonStaticState extends AutomatonState {

	@:arpField("console") public var console:Console;

	public function new() super();

	override public function toConsole():Console return this.console;
}
