package lib.sro.engine;

import lib.sro.ui.impl.BasicUI;
import lib.sro.layers.DebugLayer;

/**
 * ...
 * @author Sebastien roelandt
 */
class CollisionGrid extends BasicUI
{
	private var tileHeigth			:Float; 
	private var tileWidth			:Float; 

	private var xTiles				:Int; 
	private var yTiles				:Int; 
	
	private var grid				:Array<Array<Bool>>; 
	
	public function new(tileHeigth:Float, tileWidth:Float, xTiles:Int, yTiles:Int, ?grid:Array<Array<Bool>> = null, ?parent = null) 
	{
		super(parent);
		
		this.tileHeigth = tileHeigth; 
		this.tileWidth = tileWidth; 
		this.xTiles = xTiles; 
		this.yTiles = yTiles; 
		 
		if (grid != null) { 
			this.grid = grid; 
		} else { 
			this.grid = new Array(); 
			for (y in 0...yTiles) { 
				var line = new Array(); 
				for (x in 0...xTiles) { 
					line[x] = false; 
				} 
				this.grid[y] = line; 
			} 
		} 
	}
	
	override public function update(delta:Float) {
		this.visible = DebugLayer.isDisplay; 
		
		super.update(delta);
	}
	
	public function getGrid():Array<Array<Bool>> {
		return grid;
	}
	
	public function setCollisionOnTile(x:Int, y:Int, ?isBlocking = true) {
		if (xTiles > x && yTiles > y) { 
			this.grid[y][x] = isBlocking; 

			this.graphics.beginFill(isBlocking ? 0xe08f16 : 0x00FF00, 0.5); 
			this.graphics.drawRect(x * tileWidth, y * tileHeigth, tileWidth, tileHeigth); 
			this.graphics.endFill(); 
		} 
	}
	
}