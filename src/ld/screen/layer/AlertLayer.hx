package ld.screen.layer;

import ld.event.IAlertListener;
import lib.sro.core.Bezier.BezierType;
import lib.sro.core.Bezier;
import lib.sro.layers.DrawableLayer;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.Lib;

/**
 * ...
 * @author Roelandt Sebastien
 */
class AlertLayer extends DrawableLayer implements IAlertListener
{
	var background : Sprite;
	
	//Effect
	var bezierType : BezierType;
	var bezier : Bezier;
	var beginTime :	Float;
	static var time = 300;

	public function new() 
	{
		super();
		
		this.bezierType = BezierType.FastOut;
		this.bezier = new Bezier(this.bezierType);
		
		addBackground();	
	}
	
	private function addBackground() {
		background = new Sprite();
		background.graphics.beginFill(0xFF0000);
		background.graphics.drawRect(0, 0, 800, 600);
		background.graphics.endFill();
		background.alpha = 0;
		background.visible = false;
		this.addChild(background);
	}
	
	public function onAlert() {
		//if (!background.visible) {
			beginTime = Lib.getTimer();
			background.visible = true;
		//}
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		
		if (background.visible) {
			var currentTime = Lib.getTimer();
			var bezierValue = bezier.getValue((currentTime - beginTime)/time);
		
			if (bezierValue == - 1.00) {
				// End
				background.alpha = 0; 
				background.visible = false;
			} else {
				background.alpha = (1 - bezierValue) * 0.5;
			}
		}
	}
}