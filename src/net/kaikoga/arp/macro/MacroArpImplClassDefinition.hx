package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

using haxe.macro.TypeTools;

class MacroArpImplClassDefinition {

	public var isInterface:Bool;
	public var fields(default, null):Array<Field>;

	@:access(haxe.macro.TypeTools)
	public function new(implType:ComplexType) {
		this.fields = [];

		var classType:ClassType = null;
		switch (Context.resolveType(implType, Context.currentPos())) {
			case Type.TInst(classRef, params):
				classType = classRef.get();
			case _:
				throw "impl must be class or interface instance";
		}

		// extract fields from interfaces which fields must be explicitly typed
		// types of class instance fields may be TLazy and therefore unable to generate delegate methods
		var interfaces:Array<ClassType>;
		if (classType.isInterface) {
			this.isInterface = true;
			interfaces = [classType];
		} else {
			this.isInterface = false;
			interfaces = [for (intf in classType.interfaces) intf.t.get()];
		}

		for (intf in interfaces) {
			for (classField in intf.fields.get()) {
				if (!classField.isPublic) continue;
				switch (classField.kind) {
					case FieldKind.FMethod(_):
						this.genMethodDelegate(classField);
					case FieldKind.FVar(r, w):
						var isR:Bool = switch (r) {
							case VarAccess.AccNormal, VarAccess.AccInline, VarAccess.AccCall: true;
							case _: false;
						};
						var isW:Bool = switch (w) {
							case VarAccess.AccNormal, VarAccess.AccInline, VarAccess.AccCall: true;
							case _: false;
						};
						this.genVarDelegate(classField, isR, isW);
				}
			}
		}
	}

	private function genVarDelegate(classField:ClassField, isR:Bool, isW:Bool):Void {
		var iNativeName:String = classField.name;
		var nativeType:ComplexType = classField.type.toComplexType();

		var delegate:Field = {
			name: classField.name,
			doc: classField.doc,
			access: [Access.APublic],
			kind: FieldType.FProp(
				isR ? 'get' : 'never',
				isW ? 'set' : 'never',
				nativeType,
				null
			),
			pos: classField.pos,
			meta: classField.meta.get()
		};
		this.fields.push(delegate);

		if (isR) {
			var iGet_nativeName:String = "get_" + iNativeName;
			var getter:Field = (macro class Generated {
				@:pos(nativeField.pos) @:noDoc @:noCompletion
				/* inline */ private function $iGet_nativeName():$nativeType return this.arpImpl.$iNativeName;
			}).fields[0];
			this.fields.push(getter);
		}

		if (isW) {
			var iSet_nativeName:String = "set_" + iNativeName;
			var setter:Field = (macro class Generated {
				@:pos(nativeField.pos) @:noDoc @:noCompletion
				/* inline */ private function $iSet_nativeName(value:$nativeType):$nativeType return this.arpImpl.$iNativeName = value;
			}).fields[0];
			this.fields.push(setter);
		}
	}

	private function genMethodDelegate(classField:ClassField):Void {
		var iNativeName:String = classField.name;

		var cfKind = classField.kind;
		var cfType = switch (Context.followWithAbstracts(classField.type)) {
			case Type.TLazy(lazy): lazy();
			case type: type;
		};

		var delegate:Field = {
			name: classField.name,
			doc: classField.doc,
			access: [Access.APublic],
			kind: switch [cfKind, cfType] {
				case [FieldKind.FMethod(_), Type.TFun(args, ret)]:
					FieldType.FFun({
						args: [
							for (a in args) ({
								name: a.name,
								opt: a.opt,
								type: Context.toComplexType(a.t)
							})
						],
						ret: Context.toComplexType(ret),
						expr: macro return ${{
							expr: ExprDef.ECall(
								macro this.arpImpl.$iNativeName,
								[for (a in args) { expr: ExprDef.EConst(Constant.CIdent(a.name)), pos:Context.currentPos() } ]
							),
							pos: Context.currentPos()
						}}
					});
				default:
					throw "Invalid " + Std.string(classField);
			},
			pos: classField.pos,
			meta: classField.meta.get()
		};
		this.fields.push(delegate);
	}
}

#end
