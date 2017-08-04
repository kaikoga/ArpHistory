package net.kaikoga.arpx.backends.flash.texture;

import net.kaikoga.arpx.backends.cross.texture.ITextureImpl;
import flash.geom.Rectangle;
import flash.display.BitmapData;

interface ITextureFlashImpl extends ITextureImpl {

	function bitmapData():BitmapData;
	function trim(bound:Rectangle):BitmapData;
}
