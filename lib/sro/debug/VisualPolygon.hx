package lib.sro.debug;

import lib.sro.ui.constraint.IBasicUI;
import lib.sro.ui.impl.BasicUI;
import openfl.geom.Point;
import lib.sro.layers.DebugLayer;

/**
 * ...
 * @author Sebastien roelandt
 */
class VisualPolygon extends BasicUI
{

	public function new(points:Array<Point>, ?size = 1, ?color = 0xFF0000) 
	{
		super();
		
		this.graphics.beginFill(color, 1);
		graphics.lineStyle(size, color);
		graphics.moveTo(points[0].x, points[0].y);
		for (i in 1...points.length) {
			graphics.lineTo(points[i].x, points[i].y);
		}
		this.graphics.endFill();
	}

	override public function update(delta:Float) 
	{
		super.update(delta);
		this.visible = DebugLayer.isDisplay;
	}
	
}