package net.kaikoga.arp.ds;

import net.kaikoga.arp.ds.tree.TreePrinter;

class TreeItem<T> {

	public var children(get, never):Array<TreeItem<T>>;
	private var _children:Array<Dynamic>;
	private function get_children():Array<Dynamic> {
		return (this._children != null) ? this._children : (this._children = []);
	}

	public var hasChildren(get, never):Bool;
	private function get_hasChildren():Bool {
		return (this._children != null) && (this._children.length > 0);
	}

	public var label:String;
	public var value:T;

	public function new(value:Dynamic, label:Dynamic = null) {
		super();
		this.value = value;
		this.label = label;
	}

	public function toString():String {
		return new TreePrinter().format([this]);
	}
}


