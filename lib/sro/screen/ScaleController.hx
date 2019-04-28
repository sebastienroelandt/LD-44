package lib.sro.screen;
import openfl.display.Sprite;

/**
 * ...
 * @author Sebastien roelandt
 */
class ScaleController extends Sprite
{

	public function new() 
	{
		
	}
	
	public function updateScreenSize()
	{
		var expectedHeight:Int = 800;
		var actualHeight:Int = cast stage.stageHeight;
		
		var startScale = zoomContainer.scaleY;
		var idealScale:Float;
		
		// scale to fit
		zoomContainer.height = stage.stageHeight;
		zoomContainer.scaleX = zoomContainer.scaleY;
		
		// set ideal scaling
		idealScale = zoomContainer.scaleY;
		
		// animate scale
		if (idealScale != startScale)
		{
			zoomContainer.scaleX = zoomContainer.scaleY = startScale;
			Actuate.tween(zoomContainer, 0.5, { scaleX: idealScale, scaleY: idealScale } ).onUpdate(centerZoomContainer);
		}
		else
		{
			zoomContainer.scaleX = zoomContainer.scaleY = idealScale;
		}
		
		centerZoomContainer();
	}
	
	function centerZoomContainer()
	{
		// vertical center
		zoomContainer.x = (stage.stageWidth / 2) - (Screen.WIDTH * zoomContainer.scaleX / 2);
		zoomContainer.y = (stage.stageHeight / 2) - (Screen.HEIGHT * zoomContainer.scaleY / 2);
	}
}