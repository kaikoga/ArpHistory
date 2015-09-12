package net.kaikoga.task;

import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.utils.Dictionary;

class TaskRunner {

	public var verbose:Bool = false;

	public var cpuTime:Float = 50;

	private var _isEternal:Bool= false;
	private var _isDeadlock:Bool = false;
	private var _beacon:ITaskRunnerBeacon;
	private var _liveTasks:Array<ITask>;
	private var _readyTasks:Array<ITask>;
	private var _waitingTasks:Array<ITask>;
	private var processedSomething:Bool = false;

	public var tasksProcessed(default, null):Int = 0;
	public var tasksTotal(default, null):Int = 0;
	public var tasksWaiting(default, null):Int = 0;

	public var tasksProcessed(default, never):Bool;
	public function get_isRunning():Bool {
		return this.isActive || this.isWaiting;
	}

	public var isActive(default, never):Bool;
	public function get_isActive():Bool {
		return this._tasksTotal != this._tasksProcessed;
	}

	public var isWaiting(default, never):Bool;
	public function get_isWaiting():Bool {
		return this._tasksWaiting > 0;
	}

	public function TaskRunner(beacon:ITaskRunnerBeacon = null) {
		super();
		this._beacon = beacon;
		this._liveTasks = [];
		this._readyTasks = [];
		this._waitingTasks = [];
	}

	public function start(isEternal:Bool = false):Void {
		if (this._beacon == null) this._beacon = TaskRunnerBeacon.defaultBeacon;
		this._beacon.add(this);
		this._isEternal = isEternal;
	}

	public function prepend(task:ITask):Void {
		if (this._isDeadlock) {
			this._beacon.add(this);
			this._isDeadlock = false;
		}
		this.notify(task);
		this._liveTasks.push(task);
		this._tasksTotal++;
	}

	/**
		 * Add a task to this task queue.
		 * @param task A task to execute.
		 */

	public function append(task:*):void {
		if (this._isDeadlock) {
			this._beacon.add(this);
			this._isDeadlock = false;
		}
		this.notify(task);
		this._liveTasks.unshift(task);
		this._tasksTotal++;
	}

	/**
		 * Skip task execution until next notify() call.
		 * @param task A task, which may be either queued or not queued.
		 */

	public function wait(task:*):void {
		if (!(task in this._waitingTasks)) {
		this._waitingTasks[task] = task;
		this._tasksWaiting++;
		}
	}

	/**
		 * Resume task execution which is skipped by wait().
		 * @param task A task, which is wait()ing.
		 */

	public function notify(task:*):void {
		if (task in this._waitingTasks) {
		delete this._waitingTasks[task];
		this._tasksWaiting--;
		this.processedSomething = true;
		}
	}

	/**
		 * Cancel a task.
		 * @param task A task in this task queue to cancel.
		 * @return true if call succeeds.
		 */

	public function halt(task:*):Boolean {
		var i:int;
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
		if (this.willTrigger(ProgressEvent.PROGRESS)) {
			this.dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, this._tasksProcessed, this._tasksTotal))
		}
	}

	private function runOneTask(task:ITask):Bool {
		return itask.run();
	}

	public function tick():Void {
		var endTime:Float = new Date().getTime() + this.cpuTime;
		do {
			var task:ITask = this._liveTasks.pop();
			if (!task) {
				break;
			} else if (this._waitingTasks.indexOf(task) >= 0) {
				this._readyTasks.push(task);
				continue;
			}
			// true: done false: call later
			// For continuation, either:
			// * return true and re-register as another task, or
			// * use ITask and return false.
			var status:Boolean;
			if (this.willTrigger(AsyncErrorEvent.ASYNC_ERROR)) {
				try {
					status = runOneTask(task);
				} catch (e:Error) {
					this.dispatchEvent(new AsyncErrorEvent(AsyncErrorEvent.ASYNC_ERROR, false, false, "TaskRunner.tick(): TaskRunner has encountered an error: " + e.message, e))
				}
			} else {
				status = runOneTask(task);
			}
			if (status) {
				this._tasksProcessed++;
				this.processedSomething = true;
			} else {
				this._readyTasks.push(task);
			}
			if (this.verbose) {
				this.triggerProgressEvent();
			}
		} while (new Date().getTime() < endTime);
		// Tasks seems to be over?
		if (this._liveTasks.length == 0) {
			if (this._readyTasks.length > 0) {
				// Check if anything has proceeded
				if (this.processedSomething) {
					// Rotate ready tasks and make them live again
					this._liveTasks = this._readyTasks;
					this._readyTasks = [];
					this.processedSomething = false;
				} else if (this._tasksWaiting > 0) {
					if (!this.verbose) {
						this.triggerProgressEvent();
					}
				} else {
					// No work done, tasks depends each other, we can only halt
					this._isDeadlock = true;
					if (this.willTrigger(ErrorEvent.ERROR)) {
						this.dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, "TaskRunner.tick(): TaskRunner has encountered a deadlock"));
					}
					//deadlock is fatal, so we must stop
					this._beacon.remove(this);
				}
			} else {
				if (this._tasksWaiting > 0) {
					if (!this.verbose) {
						this.triggerProgressEvent();
					}
				} else {
					// No tasks, no ready tasks, done!
					this.dispatchEvent(new Event(Event.COMPLETE));
					if (!this._isEternal) {
						this._beacon.remove(this);
					}
				}
			}
		} else {
			if (!this.verbose) {
				this.triggerProgressEvent();
			}
		}
	}

}

