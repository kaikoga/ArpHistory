package net.kaikoga.arp.task;

import net.kaikoga.arp.events.ArpProgressEvent;
import net.kaikoga.arp.events.ArpSignal;

class TaskRunner<T:ITask> {

	public var verbose:Bool = false;

	public var cpuTime:Float = 50;

	private var _beacon:ArpSignal<Float>;
	private var _liveTasks:Array<T>;
	private var _readyTasks:Array<T>;
	private var _waitingTasks:Array<T>;
	private var processedSomething:Bool = false;

	public var tasksProcessed(default, null):Int = 0;
	public var tasksTotal(default, null):Int = 0;
	public var tasksWaiting(default, null):Int = 0;

	public var isAutoStart(default, default):Bool = false;
	public var isRunning(default, null):Bool = false;
	public var isDeadlock(default, null):Bool = false;

	public var isActive(get, never):Bool;
	public function get_isActive():Bool {
		return this.tasksTotal != this.tasksProcessed;
	}

	public var isWaiting(get, never):Bool;
	public function get_isWaiting():Bool {
		return this.tasksWaiting > 0;
	}

	public function get_isCompleted():Bool {
		return !(this.isActive || this.isWaiting);
	}

	public var onProgress(default, null):ArpSignal<ArpProgressEvent>;
	public var onError(default, null):ArpSignal<Dynamic>;
	public var onDeadlock(default, null):ArpSignal<Int>;
	public var onComplete(default, null):ArpSignal<Int>;
	public var onCompleteTask(default, null):ArpSignal<T>;

	public function new(beacon:ArpSignal<Float> = null, isAutoStart:Bool = false) {
		this._beacon = beacon;
		this.isAutoStart = isAutoStart;

		this._liveTasks = [];
		this._readyTasks = [];
		this._waitingTasks = [];

		this.onProgress = new ArpSignal();
		this.onError = new ArpSignal();
		this.onDeadlock = new ArpSignal();
		this.onComplete = new ArpSignal();
		this.onCompleteTask = new ArpSignal();
	}

	public function start():Void {
		if (!this.isRunning) {
			if (this._beacon == null) this._beacon = TaskRunner.defaultBeacon;
			this._beacon.push(this.tick);
			this.isRunning = true;
		}
	}

	public function stop():Void {
		if (this.isRunning) {
			this._beacon.remove(this.tick);
			this.isRunning = false;
		}
	}

	/**
	 * Add a task to this task queue.
	 * @param task A task to execute.
	 */
	public function prepend(task:T):Void {
		this.isDeadlock = false;
		this.notify(task);
		this._liveTasks.push(task);
		this.tasksTotal++;
		if (this.isAutoStart) this.start();
	}

	/**
	 * Add a task to this task queue.
	 * @param task A task to execute.
	 */
	public function append(task:T):Void {
		this.isDeadlock = false;
		this.notify(task);
		this._liveTasks.unshift(task);
		this.tasksTotal++;
		if (this.isAutoStart) this.start();
	}

	/**
	 * Skip task execution until next notify() call.
	 * @param task A task, which may be either queued or not queued.
	 */
	public function wait(task:T):Void {
		if (this._waitingTasks.indexOf(task) < 0) {
			this._waitingTasks.push(task);
			this.tasksWaiting++;
		}
	}

	/**
	 * Resume task execution which is skipped by wait().
	 * @param task A task, which is wait()ing.
	 */
	public function notify(task:T):Void {
		this.isDeadlock = false;
		if (this._waitingTasks.indexOf(task) >= 0) {
			this._waitingTasks.remove(task);
			this.tasksWaiting--;
			this.processedSomething = true;
		}
	}

	/**
	 * Cancel a task.
	 * @param task A task in this task queue to cancel.
	 * @return true if call succeeds.
	 */
	public function halt(task:T):Bool {
		var i:Int;
		i = this._liveTasks.indexOf(task);
		if (i >= 0) {
			this._liveTasks.splice(i, 1);
			return true;
		}
		i = this._readyTasks.indexOf(task);
		if (i >= 0) {
			this._readyTasks.splice(i, 1);
			return true;
		}
		return false;
	}

	private function triggerProgressEvent():Void {
		if (this.onProgress.willTrigger()) {
			this.onProgress.dispatch(new ArpProgressEvent(this.tasksProcessed, this.tasksTotal));
		}
	}

	public function tick(cpuLoad:Float):Void {
		var endTime:Float = Date.now().getTime() + this.cpuTime * cpuLoad;
		do {
			// step 1: consume live tasks
			var task:T = this._liveTasks.pop();
			if (task == null) {
				break;
			} else if (this._waitingTasks.indexOf(task) >= 0) {
				this._readyTasks.push(task);
				continue;
			}
			var status:TaskStatus;
			if (this.onError.willTrigger()) {
				status = task.run();
			} else {
				try {
					status = task.run();
				} catch (e:Dynamic) {
					status = TaskStatus.Error(e);
				}
			}
			switch (status) {
				case TaskStatus.Complete:
					this.tasksProcessed++;
					this.processedSomething = true;
					if (this.onCompleteTask.willTrigger()) this.onCompleteTask.dispatch(task);
				case TaskStatus.Progress:
					this.processedSomething = true;
					this._readyTasks.push(task);
				case TaskStatus.Stalled:
					this._readyTasks.push(task);
				case TaskStatus.Error(e):
					this.onError.dispatch(e);
			}
			// step 2: check turnover
			if (this._liveTasks.length == 0) {
				if (this._readyTasks.length > 0) {
					// Check if anything has proceeded
					if (this.processedSomething) {
						// Rotate ready tasks and make them live again
						this._liveTasks = this._readyTasks;
						this._readyTasks = [];
						this.processedSomething = false;
					} else if (this.tasksWaiting > 0) {
						if (!this.verbose) this.triggerProgressEvent();
					} else {
						// No work done, tasks depends each other, we can only halt
						this.isDeadlock = true;
						if (!this.onDeadlock.willTrigger()) throw "TaskRunner.tick(): TaskRunner has encountered a deadlock";
						this.onDeadlock.dispatch(this.tasksTotal - this.tasksProcessed);
						//deadlock is fatal, so we must stop
						this.stop();
					}
				} else {
					if (this.tasksWaiting > 0) {
						if (!this.verbose) this.triggerProgressEvent();
					} else {
						// No tasks, no ready tasks, done!
						this.onComplete.dispatch(0);
						this.stop();
					}
				}
			}
			if (this.verbose) this.triggerProgressEvent();
		} while (Date.now().getTime() < endTime);
		// Tasks seems to be over?
		if (!this.verbose) this.triggerProgressEvent();
	}

	public static var defaultBeacon:ArpSignal<Float> = new ArpSignal<Float>();
}
