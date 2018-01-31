﻿package net.kaikoga.arpx.state;

import net.kaikoga.arpx.automaton.Automaton;
import net.kaikoga.arpx.screen.Screen;

@:access(net.kaikoga.arpx.automaton.Automaton)
@:arpType("state", "static")
class AutomatonStaticState extends AutomatonState {

	@:arpField public var automaton:Automaton;
	@:arpField("screen") public var screen:Screen;

	public function new() super();

	override private function enterState(automaton:Automaton, payload:Dynamic = null):Void {
		if (this.automaton != null) throw "this AutomatonStaticState is already active";
		this.automaton = automaton;
		super.enterState(automaton, payload);
	}

	override private function leaveState(automaton:Automaton, payload:Dynamic = null):Void {
		super.leaveState(automaton, payload);
		this.automaton = null;
	}

	override public function toScreen():Screen return this.screen;

	public function transition(key:String, payload:Dynamic = null):Bool {
		if (this.automaton == null) return false;
		return this.automaton.transition(key, payload);
	}
}