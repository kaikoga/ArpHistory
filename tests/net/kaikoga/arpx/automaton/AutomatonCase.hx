package net.kaikoga.arpx.automaton;

import net.kaikoga.arpx.automaton.events.AutomatonEventListener;
import net.kaikoga.arpx.state.AutomatonState;
import net.kaikoga.arp.domain.gen.ArpObjectGenerator;
import net.kaikoga.arp.domain.seed.ArpSeed;
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
		me.arpSlot().addReference();
	}

	private static var DEFINITION:Xml = Xml.parse('<data>
			<state name="init">
				<tag value="init" />
				<transition key="command" ref="state1" />
			</state>
			<state name="state1">
				<tag value="state1" />
				<transition key="command" ref="state2" />
				<transition key="command3" ref="state3" />
			</state>
			<state name="state2">
				<tag value="init" />
				<transition key="command" ref="state1" />
				<state ref="state2.a" />
			</state>
			<state name="state2.a">
				<tag value="state2.a" />
				<transition key="sub" ref="state2.b" />
			</state>
			<state name="state2.b">
				<tag value="state2.b" />
				<transition key="sub" ref="state2.a" />
			</state>
			<state name="state3">
				<tag value="state3" />
				<transition key="command" ref="state1" />
			</state>
		</data>');

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
		assertEquals("</init:state>", me.state.originalState.arpSlot().toString());

		me.transition("command", "params1");
		assertEquals(0, me.stateStack.length);
		assertEquals("</state1:state>", me.state.originalState.arpSlot().toString());
		assertEquals("Transition: </init:state> -> command -> </state1:state>", events.shift());
		assertEquals("Leave: </init:state>", events.shift());
		assertEquals("Enter: </state1:state>", events.shift());
		assertEquals(null, events.shift());

		me.transition("command", "params2");
		assertEquals(1, me.stateStack.length);
		assertEquals("</state2:state>", me.stateStack.getAt(0).originalState.arpSlot().toString());
		assertEquals("</state2.a:state>", me.state.originalState.arpSlot().toString());
		assertEquals("Transition: </state1:state> -> command -> </state2:state>", events.shift());
		assertEquals("Leave: </state1:state>", events.shift());
		assertEquals("Enter: </state2:state>", events.shift());
		assertEquals("Enter: </state2.a:state>,</state2:state>", events.shift());
		assertEquals(null, events.shift());

		me.transition("sub", "params3");
		assertEquals(1, me.stateStack.length);
		assertEquals("</state2:state>", me.stateStack.getAt(0).originalState.arpSlot().toString());
		assertEquals("</state2.b:state>", me.state.originalState.arpSlot().toString());
		assertEquals("Transition: </state2.a:state> -> sub -> </state2.b:state>", events.shift());
		assertEquals("Leave: </state2.a:state>,</state2:state>", events.shift());
		assertEquals("Enter: </state2.b:state>,</state2:state>", events.shift());
		assertEquals(null, events.shift());

		me.transition("sub", "params4");
		assertEquals(1, me.stateStack.length);
		assertEquals("</state2:state>", me.stateStack.getAt(0).originalState.arpSlot().toString());
		assertEquals("</state2.a:state>", me.state.originalState.arpSlot().toString());
		assertEquals("Transition: </state2.b:state> -> sub -> </state2.a:state>", events.shift());
		assertEquals("Leave: </state2.b:state>,</state2:state>", events.shift());
		assertEquals("Enter: </state2.a:state>,</state2:state>", events.shift());
		assertEquals(null, events.shift());

		me.transition("command", "params5");
		assertEquals(0, me.stateStack.length);
		assertEquals("</state1:state>", me.state.originalState.arpSlot().toString());
		assertEquals("Transition: </state2:state> -> command -> </state1:state>", events.shift());
		assertEquals("Leave: </state2.a:state>,</state2:state>", events.shift());
		assertEquals("Leave: </state2:state>", events.shift());
		assertEquals("Enter: </state1:state>", events.shift());
		assertEquals(null, events.shift());

		me.transition("command3", "params6");
		assertEquals(0, me.stateStack.length);
		assertEquals("</state3:state>", me.state.originalState.arpSlot().toString());
		assertEquals("Transition: </state1:state> -> command3 -> </state3:state>", events.shift());
		assertEquals("Leave: </state1:state>", events.shift());
		assertEquals("Enter: </state3:state>", events.shift());
		assertEquals(null, events.shift());

		me.transition("command3", "params7");
		assertEquals(0, me.stateStack.length);
		assertEquals("</state3:state>", me.state.originalState.arpSlot().toString());
		assertEquals("Error: </state3:state> -> command3 -> No transition found", events.shift());
		assertEquals(null, events.shift());
	}
}


