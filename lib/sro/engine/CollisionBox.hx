package lib.sro.engine;

/**
 * ...
 * @author Sebastien roelandt
 */
class CollisionBox
{
	var x					: Float;
	var y					: Float;
	var height				: Float;
	var width				: Float;
	
	public function new(x:Float, y:Float, height:Float, width:Float) 
	{
		this.x = x;
		this.y = y;
		this.height = height;
		this.width = width;
	}
	
	public function getX() : Float {
		return x;
	}
	
	public function getY() : Float {
		return y;
	}
	
	public function getHeight() : Float {
		return height;
	}
	
	public function getWidth() : Float {
		return width;
	}
}