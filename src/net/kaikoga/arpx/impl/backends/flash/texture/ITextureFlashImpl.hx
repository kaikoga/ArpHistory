package net.kaikoga.arpx.impl.backends.flash.texture;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import flash.geom.Rectangle;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.impl.cross.texture.ITextureImpl;
import net.kaikoga.arpx.impl.backends.flash.texture.decorators.TextureFaceInfo;

interface ITextureFlashImpl extends ITextureImpl {
	function bitmapData():BitmapData;
	function trim(bound:Rectangle):BitmapData;
	function getFaceInfo(params:IArpParamsRead = null):TextureFaceInfo;
}

#end