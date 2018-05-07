package net.kaikoga.arpx.mortal;

import net.kaikoga.arp.ds.IList;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.impl.cross.mortal.CompositeMortalImpl;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.mortal.Mortal;
import net.kaikoga.arpx.reactFrame.ReactFrame;

@:arpType("mortal", "composite")
class CompositeMortal extends Mortal {

	@:arpField public var sort:String;
	@:arpField("mortal") @:arpBarrier public var mortals:IList<Mortal>;

	@:arpImpl private var arpImpl:CompositeMortalImpl;

	public function new() super();

	override private function get_isComplex():Bool return true;

	override public function tick(timeslice:Float):Bool {
		super.tick(timeslice);
		for (mortal in this.mortals) {
			mortal.tick(timeslice);
		}
		return true;
	}

	override public function startAction(actionName:String, restart:Bool = false):Bool {
		var result:Bool = false;
		for (mortal in this.mortals) {
			result = mortal.startAction(actionName, restart) || result;
		}
		return result;
	}

	override public function react(field:Field, source:Mortal, reactFrame:ReactFrame, delay:Float):Void {
		for (mortal in this.mortals) {
			mortal.react(field, source, reactFrame, delay);
		}
	}

	override private function get_params():ArpParams {
		return new ArpParams();
	}

	override private function set_params(value:ArpParams):ArpParams {
		for (mortal in this.mortals) {
			mortal.params.copyFrom(value);
		}
		return value;
	}

}


