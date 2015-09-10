package net.kaikoga.arp.task;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

class TaskRunnerEnterFrameBeacon extends EventDispatcher implements ITaskRunnerBeacon {

	private var runners:Array<TaskRunner>;
	private var source:IEventDispatcher;

	public function TaskRunnerEnterFrameBeacon(source:IEventDispatcher = null) {
		super();
		if (source == null) source = defaultEventDispatcher;
		this.source = source;
		this.runners = new Array<TaskRunner>();
		this.source.addEventListener(Event.ENTER_FRAME, onEnterFrame)
	}

	private function onEnterFrame(event:Event):Void {
		for (runner in this.runners) {
			runner.tick();
		}
	}

	public function add(runner:TaskRunner):Void {
		var index:Int = this.runners.indexOf(runner);
		if (index < 0) {
			this.runners.push(runner);
		}
	}

	public function remove(runner:TaskRunner):Void {
		var index:Int = this.runners.indexOf(runner);
		if (index >= 0) {
			this.runners.splice(index, 1);
		}
	}

	private static var _defaultEventDispatcher:IEventDispatcher;
	public static var defaultEventDispatcher(get_defaultEventDispatcher, never):IEventDispatcher;
	public static function get_defaultEventDispatcher():IEventDispatcher {
		if (!_defaultEventDispatcher) {
			_defaultEventDispatcher = new Sprite();
		}
		return _defaultEventDispatcher;
	}

}
