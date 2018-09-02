package arpx.impl.stub;

#if arp_display_backend_stub

import arp.domain.ArpDomain;
import arpx.impl.stub.display.DisplayContext;
import arpx.impl.stub.geom.Transform;

class ArpEngineShell {

	public var domain(default, null):ArpDomain;

	private var width:Int;
	private var height:Int;
	private var clearColor:UInt;

	public function new(params:ArpEngineParams) {
		this.domain = params.domain;
		this.width = params.width;
		this.height = params.width;
	}

	private var _displayContext:DisplayContext;

	public function createDisplayContext():DisplayContext {
		if (this._displayContext != null) return this._displayContext;
		this._displayContext = new DisplayContext(this.width, this.height, new Transform(), this.clearColor);
		return this._displayContext;
	}
}

#end
