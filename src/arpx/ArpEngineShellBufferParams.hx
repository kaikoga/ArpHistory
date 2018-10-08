package arpx;

@:structInit
class ArpEngineShellBufferParams {
	public var width:Int = 640;
	public var height:Int = 480;
	@:optional public var scaleX:Float = 1.0;
	@:optional public var scaleY:Float = 1.0;
	@:optional public var bufferMode:ArpEngineShellBufferMode = ArpEngineShellBufferMode.Automatic;
	public var clearColor:UInt = 0xff000000;

	@:optional public var clearColor24(get, never):UInt;
	private function get_clearColor24():UInt return clearColor | 0xff000000;
}
