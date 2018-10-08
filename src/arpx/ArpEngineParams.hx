package arpx;

class ArpEngineParams {
	public var shellBuffer:ArpEngineShellBufferParams;
	public var events:ArpEngineEventParams;

	public function new() return;

	public function initShellBuffer(shellBuffer:ArpEngineShellBufferParams):Void {
		this.shellBuffer = shellBuffer;
	}

	public function initEvents(events:ArpEngineEventParams):Void {
		this.events = events;
	}
}
