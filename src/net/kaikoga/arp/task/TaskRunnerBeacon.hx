package net.kaikoga.task;

class TaskRunnerBeacon implements ITaskRunnerBeacon {

	private var runners:Array<TaskRunner>;

	public function TaskRunnerBeacon() {
		super();
		this.runners = [];
	}

	public function tick():Void {
		for (runner in this.runners) runner.tick();
	}

	public function add(runner:TaskRunner):Void {
		var index:Int = this.runners.indexOf(runner);
		if (index < 0) this.runners.push(runner);
	}

	public function remove(runner:TaskRunner):Void {
		var index:Int = this.runners.indexOf(runner);
		if (index >= 0) this.runners.splice(index, 1);
	}

	public static var defaultBeacon(get, never):TaskRunnerBeacon;
	private static var _defaultBeacon:TaskRunnerBeacon;
	private static function get_defaultBeacon():TaskRunnerBeacon {
		if (!_defaultBeacon) {
			_defaultBeacon = new TaskRunnerBeacon();
		}
		return _defaultBeacon;
	}

}
