package lib.sro.entity.impl;

import lib.sro.data.StatedAnimationData;
import lib.sro.entity.constraint.IMovableEntity;
import lib.sro.entity.impl.BasicEntity;
import lib.sro.ui.impl.BasicUI;

/**
 * ...
 * @author Sebastien roelandt
 */
enum MoveDirection {
	Up;
	UpLeft;
	Left;
	DownLeft;
	Down;
	DownRight;
	Right;
	UpRight;
}

class MovableEntity extends BasicEntity implements IMovableEntity
{
	private var dx			: Float;
	private var dy			: Float;
	
	private var direction	: MoveDirection;

	public function new(statedAnimationData:StatedAnimationData, ?parent:BasicUI=null) 
	{
		super(statedAnimationData, parent);
		
		dx = 0;
		dy = 0;
		direction = Up;
	}
	
	override public function entityUpdate(delta:Float) 
	{		
		super.entityUpdate(delta);
		
		xx += dx;
		yy += dy; 
	}
	
	public function setDx(dx : Float) {
		this.dx = dx;
	}

	public function getDx() : Float {
		return this.dx;
	}

	public function setDy(dy : Float) {
		this.dy = dy;
	}

	public function getDy() : Float {
		return this.dy;
	}
	
	public function setDirection(direction : MoveDirection) {
		this.direction = direction;
	}

	public function getDirection() : MoveDirection {
		return this.direction;
	}

}