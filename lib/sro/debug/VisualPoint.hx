package lib.sro.debug;

import lib.sro.ui.impl.BasicUI;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import lib.sro.layers.DebugLayer;

/**
 * ...
 * @author Sebastien roelandt
 */
class VisualPoint extends BasicUI
{
	var follow 		: BasicUI;
	
	public function new(position:Point, ?size = 1, ?color = 0xFF0000) 
	{
		super();
		
		this.graphics.beginFill(color, 1);
		this.graphics.drawRect(0, 0, size, size);
		this.graphics.endFill();
		
		this.x = position.x;
		this.y = position.y;
	}
	
	public function setPosition(position:Point) {
		this.x = position.x;
		this.y = position.y;
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		this.visible = DebugLayer.isDisplay;
	}
	
}