package lib.sro.entity.constraint;

import lib.sro.entity.constraint.IBasicEntity;
import lib.sro.entity.impl.MovableEntity;

/**
 * @author Sebastien roelandt
 */
interface IMovableEntity extends IBasicEntity
{
	public function setDx(dx : Float) : Void;
	public function getDx() : Float;
	public function setDy(dy : Float) : Void;
	public function getDy() : Float;
	public function setDirection(direction : MoveDirection) : Void;
	public function getDirection() : MoveDirection;
}