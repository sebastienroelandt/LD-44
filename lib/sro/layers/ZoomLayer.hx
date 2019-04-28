package lib.sro.layers;
import lib.sro.ui.impl.BasicUI;
import openfl.display.Sprite;
import lib.sro.input.Mouse;

/**
 * ...
 * @author Sebastien roelandt
 */
class ZoomLayer extends BasicUI
{
	var zoom:Float;

	public function new() 
	{
		super();
		zoom = 1;
	}
	
	public override function update(delta:Float) {
		if (Mouse.isScrollUp()) {
			zoom += 0.1;
			this.scaleX = this.scaleY = zoom;
		} else if (Mouse.isScrollDown()) {
			zoom -= 0.1;
			this.scaleX = this.scaleY = zoom;
		}
	}
}