package lib.sro.entity.constraint;

/**
 * @author Sebastien roelandt
 */
typedef BorderCollision = { actual : Int, previous : Int }
 
interface ICollisionableEntity extends IMovableEntity
{
	public function setDeltaUp(deltaUp : Int) : Void;
	public function getDeltaUp() : Int;
	public function setDeltaDown(deltaDown : Int) : Void;
	public function getDeltaDown() : Int;
	public function setDeltaLeft(deltaLeft : Int) : Void;
	public function getDeltaLeft() : Int;
	public function setDeltaRight(deltaRight : Int) : Void;
	public function getDeltaRight() : Int;
	
	public function setBorderCollisionUp(borderCollisionUp : BorderCollision) : Void;
	public function getBorderCollisionUp() : BorderCollision;
	public function setBorderCollisionDown(borderCollisionDown : BorderCollision) : Void;
	public function getBorderCollisionDown() : BorderCollision;
	public function setBorderCollisionLeft(borderCollisionLeft : BorderCollision) : Void;
	public function getBorderCollisionLeft() : BorderCollision;
	public function setBorderCollisionRight(borderCollisionRight : BorderCollision) : Void;
	public function getBorderCollisionRight() : BorderCollision;
}