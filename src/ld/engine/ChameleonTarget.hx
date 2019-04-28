package ld.engine;

import flash.display.Bitmap;
import lib.sro.layers.DrawableLayer;
import lib.sro.core.GameController;

/**
 * ...
 * @author Roelandt Sebastien
 */
class ChameleonTarget extends Target
{
	var nextChangeTimer: Float;
	var nextColor: Bitmap;
	
	var isColorChanging : Bool;

	public function new(world:DrawableLayer) 
	{
		super(generateNewColor(), world);
		
		this.targetType = TargetType.chameleon;
		
		nextColor = new Bitmap();
		nextColor.alpha = 0;
		this.addChildAt(nextColor, 1);
		
		generateNextChangeTimer();
	}
	
	private function generateNextChangeTimer() {
		nextChangeTimer = 500 + Std.random(3500); 
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		
		nextChangeTimer -= delta;
		if (nextChangeTimer < 0 && !isColorChanging) {
			isColorChanging = true;
			nextColor.bitmapData = GameController.assets.getBitmapData(generateNewColor());
		}
		
		if (isColorChanging) {
			nextColor.alpha = nextColor.alpha + 0.02;
		} 
		
		if (nextColor.alpha >= 1) {
			// End
			colorBitmap.bitmapData = nextColor.bitmapData;
			nextColor.alpha = 0;
			
			isColorChanging = false;
			generateNextChangeTimer();
		}
		
	}
	
	public function generateNewColor(): String {
		var colors = [TargetType.blue, TargetType.brown, TargetType.gray, TargetType.green, 
			TargetType.purple, TargetType.red, TargetType.yellow];
		var result = "";
		do {
			var randomIndex = Std.random(colors.length);
			result = colors[randomIndex];
		} while (result == targetType);
		return result;		
	}
	
	override public function displayProfil() 
	{
		colorBitmap.bitmapData = GameController.assets.getBitmapData(TargetType.chameleon);
	}
	
}