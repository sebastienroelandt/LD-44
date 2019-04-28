package lib.sro.ui.constraint;

import lib.sro.entity.constraint.IAbstractEntity;
import openfl.display.Sprite;

/**
 * @author Sebastien roelandt
 */
interface IAnimatedSprite extends IAbstractEntity
{
	public function change(name:String):Void;
	public function addToQueue(name:String):Void;
	public function update(delta:Float):Void;
	public function getBitmapHeigth():Float;
	public function getBitmapWidth():Float;
	public function getCurrentAnimationName():String;
}