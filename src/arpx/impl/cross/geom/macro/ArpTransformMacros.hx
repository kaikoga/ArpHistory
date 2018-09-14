package arpx.impl.cross.geom.macro;

import haxe.macro.Expr;

import arp.seed.ArpSeed;
import arp.persistable.IPersistOutput;
import arp.persistable.IPersistInput;

class ArpTransformMacros {

	macro public static function initWithSeed(seed:ExprOf<ArpSeed>):ExprOf<ArpTransform> {
		return macro @:mergeBlock {
			if (seed == null) return this;
			if (seed.isSimple) return this.initWithString(seed.value, seed.env.getUnit);

			var xx:Float = 1.0;
			var yx:Float = 0.0;
			var xy:Float = 0.0;
			var yy:Float = 1.0;
			var tx:Float = 0.0;
			var ty:Float = 0.0;
			for (child in seed) {
				switch (child.typeName) {
					case "a", "xx": xx = arp.utils.ArpStringUtil.parseFloatDefault(child.value, 1.0);
					case "b", "yx": yx = arp.utils.ArpStringUtil.parseFloatDefault(child.value, 0.0);
					case "c", "xy": xy = arp.utils.ArpStringUtil.parseFloatDefault(child.value, 0.0);
					case "d", "yy": yy = arp.utils.ArpStringUtil.parseFloatDefault(child.value, 1.0);
					case "x", "tx": tx = arp.utils.ArpStringUtil.parseRichFloat(child.value, seed.env.getUnit);
					case "y", "ty": ty = arp.utils.ArpStringUtil.parseRichFloat(child.value, seed.env.getUnit);
				}
			}
			return this.reset(xx, yx, xy, yy, tx, ty);
		}
	}

	macro public static function initWithString(definition:ExprOf<String>, getUnit:ExprOf<String->Float>):ExprOf<ArpTransform> {
		return macro @:mergeBlock {
			if (definition == null) return this;
			var array:Array<String> = ~/[;,]/g.split(definition);
			if (array.length < 6) return this;
			var xx = arp.utils.ArpStringUtil.parseFloatDefault(array[0], 1.0);
			var yx = arp.utils.ArpStringUtil.parseFloatDefault(array[1], 0.0);
			var xy = arp.utils.ArpStringUtil.parseFloatDefault(array[2], 0.0);
			var yy = arp.utils.ArpStringUtil.parseFloatDefault(array[3], 1.0);
			var tx = arp.utils.ArpStringUtil.parseRichFloat(array[4], getUnit);
			var ty = arp.utils.ArpStringUtil.parseRichFloat(array[5], getUnit);
			return this.reset(xx, yx, xy, yy, tx, ty);
		}
	}

	macro public static function readSelf(input:ExprOf<IPersistInput>):Expr {
		return macro @:mergeBlock {
			this.reset(
				input.readDouble("xx"),
				input.readDouble("yx"),
				input.readDouble("xy"),
				input.readDouble("yy"),
				input.readDouble("tx"),
				input.readDouble("ty")
			);
		}
	}

	macro public static function writeSelf(output:ExprOf<IPersistOutput>):Expr {
		return macro @:mergeBlock {
			// FIXME
			var array:Array<Float> = this.toData();
			output.writeDouble("xx", array[0]);
			output.writeDouble("yx", array[1]);
			output.writeDouble("xy", array[2]);
			output.writeDouble("yy", array[3]);
			output.writeDouble("tx", array[4]);
			output.writeDouble("ty", array[5]);
		}
	}
}


