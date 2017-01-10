package;

import net.kaikoga.arpx.input.InputAxis;
import net.kaikoga.arpx.input.Input;
import net.kaikoga.arpx.driver.Driver;
import net.kaikoga.arpx.mortal.Mortal;
import net.kaikoga.arpx.field.Field;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("driver", "inputLinear"))
class InputLinearDriver extends Driver {

	@:arpField public var input:Input;
	@:arpField public var speed:Float;

	public function new() {
		super();
	}

	override public function tick(field:Field, mortal:Mortal):Void {
		input.tick(1.0);
		var axisX:InputAxis = input.axis("x");
		var axisY:InputAxis = input.axis("y");
		if (axisX.isDown || axisY.isDown) {
			var inputX:Float = axisX.value;
			var inputY:Float = axisY.value;
			mortal.moveDWithHit(field, inputX * speed, 0, 0, "solid");
			mortal.moveDWithHit(field, 0, inputY * speed, 0, "solid");
			mortal.position.dir.valueRadian = -Math.atan2(inputY, inputX);
			mortal.params.set("dir", mortal.position.dir);
		}
	}
}


