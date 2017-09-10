package net.kaikoga.arpx.mortal;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.mortal.CompositeMortalFlashImpl;
#end

import net.kaikoga.arpx.reactFrame.ReactFrame;
import net.kaikoga.arp.ds.IList;
import net.kaikoga.arpx.mortal.Mortal;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.field.Field;

@:arpType("mortal", "composite")
class CompositeMortal extends Mortal {

	@:arpField public var sort:String;
	@:arpField("mortal") @:arpBarrier public var mortals:IList<Mortal>;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:CompositeMortalFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new() {
		super();
	}

	override private function get_isComplex():Bool return true;

	override public function tick(timeslice:Float):Void {
		super.tick(timeslice);
		for (mortal in this.mortals) {
			mortal.tick(timeslice);
		}
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


