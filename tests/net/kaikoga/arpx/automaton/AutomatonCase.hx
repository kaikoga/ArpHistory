package net.kaikoga.arpx.automaton;

import net.kaikoga.arpx.automaton.events.AutomatonEventListener;
import net.kaikoga.arpx.state.AutomatonState;
import net.kaikoga.arp.domain.gen.ArpObjectGenerator;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arpx.automaton.Automaton;

import net.kaikoga.arp.domain.ArpDomain;

import picotest.PicoAssert.*;

/**
	 * ...
	 * @author kaikoga
	 */
class AutomatonCase {

	private var domain:ArpDomain;
	private var me:Automaton;

	public function setup():Void {
		var seed:ArpSeed = ArpSeed.fromXml(DEFINITION);
		domain = new ArpDomain();
		domain.addGenerator(new ArpObjectGenerator(Automaton));
		domain.addGenerator(new ArpObjectGenerator(AutomatonState));
		domain.loadSeed(seed);
		me = (domain.query("init", AutomatonState).value():AutomatonState).toAutomaton();
		me.arpSlot.addReference();
	}

	private static var DEFINITION:Xml = Xml.parse('<data>
			<state name="init" label="init">
				<transition key="command" ref="state1" />
			</state>
			<state name="state1" label="state1">
				<transition key="command" ref="state2" />
				<transition key="command3" ref="state3" />
			</state>
			<state name="state2" label="state2">
				<transition key="command" ref="state1" />
				<state ref="state2.a" />
			</state>
			<state name="state2.a" label="state2.a">
				<transition key="sub" ref="state2.b" />
			</state>
			<state name="state2.b" label="state2.b">
				<transition key="sub" ref="state2.a" />
			</state>
			<state name="state3" label="state3">
				<transition key="command" ref="state1" />
			</state>
		data>');

	public function testAddEntry():Void {
		assertNotNull(domain.query("init", AutomatonState).value());
		assertNotNull(domain.query("state1", AutomatonState).value());
		assertNotNull(domain.query("state2", AutomatonState).value());
	}

	public function testAutomaton():Void {
		var listener:AutomatonEventListener = new AutomatonEventListener(me, false);
		var events:Array<String> = [];
		listener.onEvent.push(function(en:AutomatonEvents) {
			events.push(switch (en) {
				case AutomatonEvents.EnterState(ev): ev.describe();
				case AutomatonEvents.LeaveState(ev): ev.describe();
				case AutomatonEvents.Transition(ev): ev.describe();
				case AutomatonEvents.Error(ev): ev.describe();
			});
		});
		assertNotNull(me.state);
		assertNotNull(me);
		assertEquals(0, me.stateStack.length);
		assertEquals("init", me.state.originalState.label);

		me.transition("command", "params1");
		assertEquals(0, me.stateStack.length);
		assertEquals("state1", me.state.originalState.label);
		assertEquals("Transition: init -> command -> state1", events.shift());
		assertEquals("Leave: init", events.shift());
		assertEquals("Enter: state1", events.shift());
		assertEquals(null, events.shift());

		me.transition("command", "params2");
		assertEquals(1, me.stateStack.length);
		assertEquals("state2", me.stateStack.getAt(0).originalState.label);
		assertEquals("state2.a", me.state.originalState.label);
		assertEquals("Transition: state1 -> command -> state2", events.shift());
		assertEquals("Leave: state1", events.shift());
		assertEquals("Enter: state2", events.shift());
		assertEquals("Enter: state2.a, state2", events.shift());
		assertEquals(null, events.shift());

		me.transition("sub", "params3");
		assertEquals(1, me.stateStack.length);
		assertEquals("state2", me.stateStack.getAt(0).originalState.label);
		assertEquals("state2.b", me.state.originalState.label);
		assertEquals("Transition: state2.a -> sub -> state2.b", events.shift());
		assertEquals("Leave: state2.a, state2", events.shift());
		assertEquals("Enter: state2.b, state2", events.shift());
		assertEquals(null, events.shift());

		me.transition("sub", "params4");
		assertEquals(1, me.stateStack.length);
		assertEquals("state2", me.stateStack.getAt(0).originalState.label);
		assertEquals("state2.a", me.state.originalState.label);
		assertEquals("Transition: state2.b -> sub -> state2.a", events.shift());
		assertEquals("Leave: state2.b, state2", events.shift());
		assertEquals("Enter: state2.a, state2", events.shift());
		assertEquals(null, events.shift());

		me.transition("command", "params5");
		assertEquals(0, me.stateStack.length);
		assertEquals("state1", me.state.originalState.label);
		assertEquals("Transition: state2 -> command -> state1", events.shift());
		assertEquals("Leave: state2.a, state2", events.shift());
		assertEquals("Leave: state2", events.shift());
		assertEquals("Enter: state1", events.shift());
		assertEquals(null, events.shift());

		me.transition("command3", "params6");
		assertEquals(0, me.stateStack.length);
		assertEquals("state3", me.state.originalState.label);
		assertEquals("Transition: state1 -> command3 -> state3", events.shift());
		assertEquals("Leave: state1", events.shift());
		assertEquals("Enter: state3", events.shift());
		assertEquals(null, events.shift());

		me.transition("command3", "params7");
		assertEquals(0, me.stateStack.length);
		assertEquals("state3", me.state.originalState.label);
		assertEquals("Error: state3 -> command3 -> No transition found", events.shift());
		assertEquals(null, events.shift());
	}
}


