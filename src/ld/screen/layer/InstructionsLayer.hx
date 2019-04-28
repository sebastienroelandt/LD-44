package ld.screen.layer;

import flash.display.Bitmap;
import ld.engine.ChameleonTarget;
import ld.ui.AdjustableBackground;
import lib.sro.core.Bezier;
import lib.sro.core.Bezier.BezierType;
import openfl.text.TextField;
import lib.sro.layers.DrawableLayer;
import lib.sro.core.Text;
import lib.sro.core.GameController;
import lib.sro.input.Keys;
import flash.ui.Keyboard;
import openfl.Lib;
import ld.screen.layer.base.InfoDisplayLayer;
import ld.engine.TargetType;

/**
 * ...
 * @author Roelandt Sebastien
 */
		
typedef Message = {
	defaultMessage : TextField,
	shadowLeft : TextField,
	shadowRight : TextField,
	shadowTop : TextField,
	shadowBottom : TextField
}

class InstructionsLayer extends InfoDisplayLayer
{
	static var TYPE = "INSTRUCTION";
	
	var images : Array<Bitmap>;
	var chameleon : ChameleonTarget;
	
	public function new() 
	{		
		super("messageBackground", 600, 520, 500);
		
		this.x = 100;
		this.y = 75;
		
		images = new Array<Bitmap>();
		chameleon = null;
	}
	
	override public function update(delta:Float) {
		super.update(delta);
	}
	
	override public function getType():String 
	{
		return InstructionsLayer.TYPE;
	}
	
	override function displayNextMessage() 
	{
		super.displayNextMessage();
		
		for (image in images) {
			this.removeChild(image);
		}
		images = new Array<Bitmap>();
		
		if (chameleon != null) {
			this.remove(chameleon);
			chameleon = null;
		}
		
		var count = 0;
		var text : String = info.defaultMessage.text;
		for (targetType in TargetType.getAll()) {
			if (text.indexOf("[" + targetType + "]") != -1) {
				var splitted = text.split("[" + targetType + "]");
				text = splitted[0] + " " + splitted[1];
				
				if (targetType == TargetType.chameleon && splitted[0].split(" x").length == 1) {
					// Cas special, il s'agit des instructions
					chameleon = new ChameleonTarget(this);
					chameleon.changeIdleTimer(1000000);
					chameleon.setXx(290);
					chameleon.setYy(110);
					this.add(chameleon);
				} else {
					var index = splitted[0].split(" x").length;
					var image = new Bitmap(GameController.assets.getBitmapData(targetType));
					image.x = 30;
					image.y = 74 + 36 * (index - 1);
					this.addChild(image);
					
					var imageBackground = new Bitmap(GameController.assets.getStatedAnimationData("target").getAnimationData("idle").getFrame(0));
					imageBackground.x = 30;
					imageBackground.y = 74 + 36 * (index - 1);
					this.addChild(imageBackground);
					
					images.push(image);
					images.push(imageBackground);
					count++;
				}
			}
		}
		
		info.defaultMessage.text = text;
		info.shadowLeft.text = text;
		info.shadowRight.text = text;
		info.shadowTop.text = text;
		info.shadowBottom.text = text;
	}
}