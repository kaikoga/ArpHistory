package;

import net.kaikoga.arpx.input.Input;
import net.kaikoga.arpx.driver.Driver;
import net.kaikoga.arpx.mortal.Mortal;
import net.kaikoga.arpx.field.Field;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("driver", "inputLinear"))
class InputLinearDriver extends Driver {

	@:arpField public var input:Input;

	public function new() {
		super();
	}

	override public function tick(field:Field, mortal:Mortal):Void {
		input.tick(1.0);
		mortal.moveDWithHit(field, input.axis("x").value, 0, 0, "solid");
		mortal.moveDWithHit(field, 0, input.axis("y").value, 0, "solid");
	}
}


