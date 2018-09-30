package arpx.chip;

import arp.domain.IArpObject;
import arpx.impl.cross.chip.IChipImpl;
import arpx.impl.cross.geom.RectImpl;
import arpx.structs.ArpParams;
import arpx.structs.IArpParamsRead;

@:arpType("chip", "null")
class Chip implements IArpObject implements IChipImpl {

	public function layoutSize(params:IArpParamsRead, rect:RectImpl):RectImpl {
		rect.reset();
		return rect;
	}

	@:deprecated("use layoutSize")
	public var chipWidth(get, set):Float;
	/* @:final */ private function get_chipWidth():Float return layoutSize(_workParams, _workRect).width;
	@:deprecated("we will deprecate chip size setters")
	/* @:final */ private function set_chipWidth(value:Float):Float return value;

	@:deprecated("use layoutSize")
	public var chipHeight(get, set):Float;
	/* @:final */ private function get_chipHeight():Float return layoutSize(_workParams, _workRect).height;
	@:deprecated("we will deprecate chip size setters")
	/* @:final */ private function set_chipHeight(value:Float):Float return value;

	@:deprecated("use layoutSize")
	@:final public function chipWidthOf(params:IArpParamsRead):Float return layoutSize(params, _workRect).width;

	@:deprecated("use layoutSize")
	@:final public function chipHeightOf(params:IArpParamsRead):Float return layoutSize(params, _workRect).height;

	@:noDoc("deprecated")
	private var _workRect:RectImpl = RectImpl.alloc();
	private var _workParams:ArpParams = new ArpParams();

	@:arpImpl private var arpImpl:IChipImpl;

	public function new() return;
}
