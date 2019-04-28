package lib.sro.entity.impl;

import lib.sro.data.StatedAnimationData;
import lib.sro.entity.constraint.ICollisionableEntity;
import lib.sro.ui.impl.BasicUI;

/**
 * ...
 * @author Sebastien roelandt
 */
 
class CollisionableEntity extends MovableEntity implements ICollisionableEntity
{
	//Delta between collision border and sprite
	private var deltaUp				: Int;
	private var deltaDown			: Int;
	private var deltaLeft			: Int;
	private var deltaRight			: Int;
	
	private var borderCollisionUp			: BorderCollision;
	private var borderCollisionDown			: BorderCollision;
	private var borderCollisionLeft			: BorderCollision;
	private var borderCollisionRight		: BorderCollision;
	
	public function new(statedAnimationData:StatedAnimationData, ?parent:BasicUI=null) 
	{
		super(statedAnimationData, parent);
		
		this.deltaUp = 0;		
		this.deltaDown = 0;	
		this.deltaLeft = 0;	
		this.deltaRight = 0;	
		
		this.borderCollisionUp = { actual: 0, previous: 0 };	
		this.borderCollisionDown = { actual: 0, previous: 0 };	
		this.borderCollisionLeft = { actual: 0, previous: 0 };	
		this.borderCollisionRight = { actual: 0, previous: 0 };	
	}
	
	override public function entityUpdate(delta:Float) 
	{
		super.entityUpdate(delta);
	}
	
	/* Getter and setter */
	public function setDeltaUp(deltaUp : Int) {
		this.deltaUp = deltaUp;
	}

	public function getDeltaUp() : Int {
		return this.deltaUp;
	}

	public function setDeltaDown(deltaDown : Int) {
		this.deltaDown = deltaDown;
	}

	public function getDeltaDown() : Int {
		return this.deltaDown;
	}

	public function setDeltaLeft(deltaLeft : Int) {
		this.deltaLeft = deltaLeft;
	}

	public function getDeltaLeft() : Int {
		return this.deltaLeft;
	}

	public function setDeltaRight(deltaRight : Int) {
		this.deltaRight = deltaRight;
	}

	public function getDeltaRight() : Int {
		return this.deltaRight;
	}
	
	public function setBorderCollisionUp(borderCollisionUp : BorderCollision) {
		this.borderCollisionUp = borderCollisionUp;
	}

	public function getBorderCollisionUp() : BorderCollision {
		return this.borderCollisionUp;
	}

	public function setBorderCollisionDown(borderCollisionDown : BorderCollision) {
		this.borderCollisionDown = borderCollisionDown;
	}

	public function getBorderCollisionDown() : BorderCollision {
		return this.borderCollisionDown;
	}

	public function setBorderCollisionLeft(borderCollisionLeft : BorderCollision) {
		this.borderCollisionLeft = borderCollisionLeft;
	}

	public function getBorderCollisionLeft() : BorderCollision {
		return this.borderCollisionLeft;
	}

	public function setBorderCollisionRight(borderCollisionRight : BorderCollision) {
		this.borderCollisionRight = borderCollisionRight;
	}

	public function getBorderCollisionRight() : BorderCollision {
		return this.borderCollisionRight;
	}
}