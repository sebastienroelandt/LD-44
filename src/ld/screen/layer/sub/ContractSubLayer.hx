package ld.screen.layer.sub;
import lib.sro.layers.DrawableLayer;
import lib.sro.core.GameController;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import lib.sro.core.Text;

/**
 * ...
 * @author Roelandt Sebastien
 */
class ContractSubLayer extends DrawableLayer
{
	var color: String;
	var value: Int;
	
	public function new(color: String, value: Int) 
	{
		super();
		
		this.color = color;
		this.value = value;
		
		//addBackground();
		
		var image = new Bitmap(GameController.assets.getBitmapData(color));
		image.x = 20;
		image.y = 10;
		this.addChild(image);
		
		var image = new Bitmap(GameController.assets.getStatedAnimationData("target").getAnimationData("idle").getFrame(0));
		image.x = 20;
		image.y = 10;
		this.addChild(image);
		
		var image : Bitmap;
		var valueDisplay = this.value;
		if (this.value > 0) {
			image = new Bitmap(GameController.assets.getBitmapData("coin"));
		} else {
			image = new Bitmap(GameController.assets.getBitmapData("coin_negatif"));
			valueDisplay = -this.value;
		}
		image.x = 5;
		image.y = 41;
		this.addChild(image);
		
		var textfield = Text.createText("Minecraftia.ttf");
		textfield.text = "x" + valueDisplay;
		textfield.x = 18;
		textfield.y = 41;
		this.addChild(textfield);
	}
	
	private function addBackground() {
		var background = new Sprite();
		background.graphics.beginFill(0x00FF00);
		background.graphics.drawRect(0, 0, 68, 68);
		background.graphics.endFill();
		this.addChild(background);
	}
	
	public function getColor(): String {
		return this.color;
	}
	
	public function getValue(): Int {
		return this.value;
	}
	
}