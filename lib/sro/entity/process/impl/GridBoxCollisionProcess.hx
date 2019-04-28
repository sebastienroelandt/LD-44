package lib.sro.entity.process.impl;

import lib.sro.engine.CollisionInformation;
import lib.sro.entity.constraint.ICollisionableEntity;
import lib.sro.entity.process.constraint.IProcess;
import lib.sro.entity.process.constraint.AbstractCollisionProcess;
import lib.sro.engine.CollisionUtils;
import lib.sro.engine.CollisionBox;

/**
 * ...
 * @author Sebastien roelandt
 */
class GridBoxCollisionProcess extends AbstractCollisionProcess implements IProcess
{
	private var priority			: Int;
	
	private var tileHeight			: Int;
	private var tileWidth			: Int;
	private var collisionMap		: Array<Array<Bool>>;
	private var xTiles				: Int;
	private var yTiles				: Int;
	
	//collision calculation
	private var entityHeightInTile	: Int;
	private var entityWidthInTile	: Int;
	private var restHeight			: Float;
	private var restWidth 			: Float;
	
	//Entity position
	private var cx					: Int;
	private var cy					: Int;
	private var xr					: Float;
	private var yr					: Float;
	

	public function new(entity:ICollisionableEntity, tileHeight:Int, tileWidth:Int, 
		collisionMap:Array<Array<Bool>>, ?isBlocking = true) 
	{
		super(entity, isBlocking);
		
		this.priority = ProcessesOrder.GRID_BOX_COLLISION_PRIORITY;
		this.entity = entity;
		
		this.tileHeight = tileHeight;
		this.tileWidth = tileWidth;
		this.xTiles = collisionMap.length;
		this.yTiles = collisionMap[0].length;
		this.collisionMap = collisionMap;
		this.isBlocking = isBlocking;
		
		this.entityHeightInTile = Std.int((entity.getHeight() - entity.getDeltaUp() + entity.getDeltaDown()) / tileHeight);
		this.entityWidthInTile = Std.int((entity.getWidth() - entity.getDeltaLeft() + entity.getDeltaRight()) / tileWidth);
	}
		
	private function isOnCollisionTile(x:Int, y:Int):Bool {
		var toReturn = false;
		if (xTiles > x && yTiles > y && y >= 0 && x >= 0) {
			toReturn = collisionMap[Std.int(y)][Std.int(x)];
		}
		return toReturn;
	}
	
	private function getMinMaxXCheck():{min:Int, max:Int} {
		var xRealPosition = entity.getXx();
		var xGridPosition = Std.int((xRealPosition + entity.getDeltaLeft())/ tileWidth);
		return {min: xGridPosition - 1, max: xGridPosition + 1 + entityWidthInTile};
	}
	
	private function getMinMaxYCheck():{min:Int, max:Int} {
		var yRealPosition = entity.getYy();
		var yGridPosition = Std.int((yRealPosition + entity.getDeltaUp())/ tileHeight);
		return {min: yGridPosition - 1, max: yGridPosition + 1 + entityHeightInTile};
	}

	public function check() {
		var x = getMinMaxXCheck();
		var y = getMinMaxYCheck();
		
		for (i in x.min...(x.max + 1)) {
			for (j in y.min...(y.max + 1)) {
				if (isOnCollisionTile(i , j)) {
					var collisionInformation = getCollisionInformation(i , j);
					if (collisionInformation.getIsCollision()) {
						//Collision
						if (collisionInformation.getCalculatedX() != 0) {
							onCollision();
							if (isBlocking) {
								entity.setDx(0);
								entity.setXx(collisionInformation.getCalculatedX() + entity.getDeltaLeft());
							}
						}
						
						if (collisionInformation.getCalculatedY() != 0) {
							onCollision();
							if (isBlocking) {
								entity.setDy(0);
								entity.setYy(collisionInformation.getCalculatedY() + entity.getDeltaUp());
							}
						}
					}
				}
			}
		}
	}
		
	private function getCollisionInformation(i : Int, j : Int) : CollisionInformation {
		return CollisionUtils.boxCollision(entity, new CollisionBox(i * tileWidth, j * tileHeight, tileWidth, tileHeight));
	}

	override public function getType():CollisionProcessType 
	{
		return CollisionProcessType.GRID;
	}
	
	public function beforeEntityUpdate(delta:Float):Void 
	{
		check();
	}
	
	public function afterEntityUpdate(delta:Float):Void 
	{
		
	}
	
	public function stop():Void 
	{
		
	}
	
	public function getPriority():Int 
	{
		return priority;
	}
	
	public function setPriority(priority:Int):Void 
	{
		this.priority = priority;
	}
}