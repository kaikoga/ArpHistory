package arpx;

#if macro

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;

class ArpEngineMacros {

	private static var instance:ArpEngineMacros;

	public static function init():Array<Field> {
		if (instance == null) instance = new ArpEngineMacros();
		return null;
	}

	private function new() { 
		var components:Array<ArpEngineBackend> = [];
		// components.push(new ArpEngineBackend("arp_texture_backend", ["heaps", "flash", "openfl"]));

		var root:ArpEngineBackend = new ArpEngineBackend("arp_backend", ["heaps", "flash", "openfl"]);
		var rootBackend:String = root.guessBackend(null);
		
		for (component in components) component.guessBackend(rootBackend);
		return;
	}
}

class ArpEngineBackend {

	private var category:String;
	private var target:String;
	private var targets:Array<String>;

	private function fullName(target:String):String return '${this.category}_${target}';

	public function new(category:String, targets:Array<String>) {
		this.category = category;
		this.targets = targets;
		this.consumeDefines();
	}

	private function consumeDefines() {
		var flagsDefined:Array<String> = [];
		for (target in this.targets) {
			var flagName:String = fullName(target);
			if (Context.defined(flagName)) flagsDefined.push(flagName);
		}
		switch (flagsDefined.length) {
			case 0:
			case 1: this.target = flagsDefined[0];
			case _: throw 'Compiler flag conflict: Backends cannot coexist: ${flagsDefined.join(",")}';
		} 
	}
	
	public function guessBackend(rootBackend:String):String {
		if (this.target != null) return this.target;

		if (rootBackend != null) this.targets.unshift(rootBackend);
		for (target in this.targets) {
			this.target = target;
			if (Context.defined(target)) break;
		}
		if (rootBackend != null) this.targets.shift();

		Compiler.define(fullName(target));
		return this.target;
	} 
}
#end
