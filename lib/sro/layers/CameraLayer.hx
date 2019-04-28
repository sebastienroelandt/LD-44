package lib.sro.layers;

import lib.sro.layers.DrawableLayer;
import openfl.geom.Point;

/**
 * ...
 * @author Sebastien roelandt
 */
class CameraLayer extends DrawableLayer
{
	var target 				: Point;
	var screenHeight		: Int;
	var screenWidth			: Int;
	var time				: Float;

	public function new(screenHeight:Int, screenWidth:Int, ?time = 50) 
	{
		super();
		
		this.target = null;
		this.screenHeight = screenHeight;
		this.screenWidth = screenWidth;
		this.time = time / 50 + 50;
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		
		moveToTarget();
	}
	
	
	
	private function moveToTarget() {
		var moveTo = getTarget();
		if (moveTo != null) {			
			//end
			if (Math.abs(this.x + moveTo.x) + Math.abs(this.y + moveTo.y) < 1) {
				moveTo = null;
			}
		}
		
		if (moveTo != null) {
			//end
			this.x -= (this.x + moveTo.x) / time;
			this.y -= (this.y + moveTo.y) / time;
		}
	}
	
	public function getTarget() : Point {
		return this.target;
	}
	
	public function setTarget (target: Point) {
		this.target = target;
		this.target.x -= screenWidth / 2;
		this.target.y -= screenHeight / 2;
	}
}