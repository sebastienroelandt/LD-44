package lib.sro.entity.process.impl;

import lib.sro.entity.process.constraint.IProcess;
import lib.sro.entity.process.ProcessesOrder;
import lib.sro.entity.constraint.IMovableEntity;
import lib.sro.entity.impl.MovableEntity.MoveDirection;
import openfl.ui.Keyboard;
import lib.sro.input.Keys;

/**
 * ...
 * @author Sebastien roelandt
 */
class MoveProcess implements IProcess
{
	private var priority				: Int;
	private var entity					: IMovableEntity;
		
	private var speed					: Float;
		
	private var upKey					: UInt;
	private var leftKey					: UInt;
	private var downKey					: UInt;
	private var rightKey				: UInt;
		
	private var isUpDownDirection		: Bool;
	private var isLeftRightDirection	: Bool;
	
	public function new(entity : IMovableEntity, ?speed = 0.5) 
	{
		this.speed = speed;
		this.priority = ProcessesOrder.MOVE_PRIORITY;
		this.entity = entity;
		this.upKey = Keyboard.UP;
		this.leftKey = Keyboard.LEFT;
		this.downKey = Keyboard.DOWN;
		this.rightKey = Keyboard.RIGHT;
		this.isUpDownDirection = false;
		this.isLeftRightDirection = false;
	}

	public function beforeEntityUpdate(delta:Float):Void 
	{
		isUpDownDirection = false;
		isLeftRightDirection = false;
		if (Keys.isDown(upKey)) {
			onUpKey();
		}
		if (Keys.isDown(leftKey)) {
			onLeftKey();
		}
		if (Keys.isDown(downKey)) {
			onDownKey();
		}
		if (Keys.isDown(rightKey)) {
			onRightKey();
		}
	}
	
	public function afterEntityUpdate(delta:Float):Void 
	{
		
	}
	
	public function stop():Void 
	{
		
	}
	
	//Event
	
	public function onUpKey() {
		entity.setDy(entity.getDy() - speed);
		entity.setDirection(MoveDirection.Up);
		isUpDownDirection = true;
	}
	
	public function onDownKey() {
		entity.setDy(entity.getDy() + speed);
		entity.setDirection(MoveDirection.Down);
		isUpDownDirection = true;
	}
	
	public function onLeftKey() {
		entity.setDx(entity.getDx() - speed);
		if (isUpDownDirection) {
			if (MoveDirection.Up == entity.getDirection()) {
				entity.setDirection(MoveDirection.UpLeft);
			} else {
				entity.setDirection(MoveDirection.DownLeft);
			}
		} else {
			entity.setDirection(MoveDirection.Left);
		}
		isLeftRightDirection = true;
	}
	
	public function onRightKey() {
		entity.setDx(entity.getDx() + speed);
		if (isUpDownDirection) {
			if (MoveDirection.Up == entity.getDirection()) {
				entity.setDirection(MoveDirection.UpRight);
			} else {
				entity.setDirection(MoveDirection.DownRight);
			}
		} else {
			entity.setDirection(MoveDirection.Right);
		}
		isLeftRightDirection = true;
	}
	
	/* Getter & setter */
	
	public function getPriority():Int 
	{
		return this.priority;
	}
	
	public function setPriority(priority:Int):Void 
	{
		this.priority = priority;
	}
	
	public function getSpeed() : Float {
		return this.speed;
	}
	
	public function setSpeed(speed : Float) {
		this.speed = speed;
	}
	
	public function setUpKey(upKey : UInt) {
		this.upKey = upKey;
	}

	public function getUpKey() : UInt {
		return this.upKey;
	}

	public function setLeftKey(leftKey : UInt) {
		this.leftKey = leftKey;
	}

	public function getLeftKey() : UInt {
		return this.leftKey;
	}

	public function setDownKey(downKey : UInt) {
		this.downKey = downKey;
	}

	public function getDownKey() : UInt {
		return this.downKey;
	}

	public function setRightKey(rightKey : UInt) {
		this.rightKey = rightKey;
	}

	public function getRightKey() : UInt {
		return this.rightKey;
	}

}