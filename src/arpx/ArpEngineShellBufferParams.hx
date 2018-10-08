package arpx;

typedef ArpEngineShellBufferParams = {
	var width:Int;
	var height:Int;
	@:optional var scaleX:Null<Float>;
	@:optional var scaleY:Null<Float>;
	@:optional var bufferMode:Null<ArpEngineShellBufferMode>;
	var clearColor:UInt;
}
