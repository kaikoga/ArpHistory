package net.kaikoga.arpx.logger;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("logger", "store"))
class StoreLogger extends Logger {

	public function new() {
		super();
	}

	private var _store:Map<String, Array<String>>;
	public var store(get, never):Map<String, Array<String>>;
	private function get_store():Map<String, Array<String>> {
		if (this._store == null) this._store = new Map<String, Array<String>>();
		return this._store;
	}

	override public function log(category:String, message:String):Void {
		if (!this.respondsTo(category)) return;

		var array:Array<String> = this.store.get(category);
		if (array == null) {
			array = [];
			this.store.set(category, array);
		}
		array.push(message);
	}

	public function dump(category:String):Array<String> {
		var result:Array<Dynamic> = this.store.get(category);
		if (result == null) {
			result = [];
		} else {
			this.store.remove(category);
		}
		return result;
	}
}


