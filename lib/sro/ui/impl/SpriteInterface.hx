package lib.sro.ui.impl;

import openfl.display.Graphics;
import openfl.display.Sprite;
import openfl.geom.Matrix;

import lib.sro.ui.constraint.ISprite;
import openfl.display.DisplayObject;

/**
 * ...
 * @author Sebastien roelandt
 */
class SpriteInterface extends Sprite implements ISprite
{

	public function new() 
	{
		super();
	}
	
	public function getSprite():Sprite {
		return this;
	}
}