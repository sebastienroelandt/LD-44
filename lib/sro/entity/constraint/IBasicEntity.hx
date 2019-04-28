package lib.sro.entity.constraint;

/**
 * @author Sebastien roelandt
 */

interface IBasicEntity extends IAbstractEntity
{
  	public function setHeight(height : Float):Void;
	public function getHeight() : Float;
	public function setWidth(width : Float):Void;
	public function getWidth() : Float;
	public function setXx(xx : Float):Void;
	public function getXx() : Float;
	public function setYy(yy : Float):Void;
	public function getYy() : Float;
}