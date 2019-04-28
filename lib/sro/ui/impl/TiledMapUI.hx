package lib.sro.ui.impl;

import lib.sro.ui.impl.BasicUI;
import lib.sro.engine.CollisionGrid;
import openfl.display.BitmapData;
import openfl.display.Bitmap;

/**
 * ...
 * @author Sebastien roelandt
 */
class TiledMapUI extends BasicUI
{
	private var collisionGrid			: CollisionGrid;	
	
	public function new(tileset:Array<BitmapData>,	values:Array<Array<Int>>, ?collisionId:Array<Int> = null) 
	{
		super();
		
		if (collisionId == null) {
			collisionId = new Array();
		}
		
		var tileHeigth:Float = tileset[0].height;
		var tileWidth:Float = tileset[0].width;
		var xmax = values[0].length;
		var ymax = values.length;
		
		this.collisionGrid = new CollisionGrid(tileHeigth, tileWidth, xmax, ymax, null, this);
			
		for (j in 0...values.length) {
			var line = values[j];
			for (i in 0...line.length) {
				var tileBitmapData = tileset[line[i]];
				
				var child = new BasicUI();
				child.addChild(new Bitmap(tileBitmapData));
				child.x = i * tileWidth;
				child.y = j * tileHeigth;
				add(child);
				
				//Collision
				if (collisionId.indexOf(line[i]) != -1) {
					collisionGrid.setCollisionOnTile(i, j);
				}
			}
		}
		
		add(collisionGrid);
	}
	
	public function getCollisionGrid():Array<Array<Bool>> {
		return collisionGrid.getGrid();
	}
}