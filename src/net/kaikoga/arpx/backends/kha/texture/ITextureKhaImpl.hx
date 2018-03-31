package net.kaikoga.arpx.backends.kha.texture;

#if arp_backend_kha

import kha.Image;
import kha.FastFloat;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.cross.texture.ITextureImpl;
import net.kaikoga.arpx.backends.kha.texture.decorators.TextureFaceInfo;

interface ITextureKhaImpl extends ITextureImpl {
	function image():Image;
	function trim(sx:FastFloat, sy:FastFloat, sw:FastFloat, sh:FastFloat):Image;
	function getFaceInfo(params:IArpParamsRead = null):TextureFaceInfo;
}

#end
