package lib.sro.ui.constraint;
import openfl.display.DisplayObject;
import openfl.display.IBitmapDrawable;

/**
 * @author Sebastien roelandt
 */
interface IBasicUI extends ISprite
{
	public function add(child:IBasicUI):Void;
	public function remove(child:IBasicUI):Void;
	public function removeAll():Void;
	public function updateAll(delta:Float):Void;
	public function update(delta:Float):Void;
	public function setPause(pause:Bool):Void;
}