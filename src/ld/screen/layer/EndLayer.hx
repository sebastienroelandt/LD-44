package ld.screen.layer;

import flash.display.Bitmap;
import ld.screen.layer.base.InfoDisplayLayer;
import lib.sro.core.GameController;

/**
 * ...
 * @author Roelandt Sebastien
 */
class EndLayer extends InfoDisplayLayer
{

	public function new(score: Float) 
	{
		super("messageBackground", 600, 400, 1);
		
		this.x = 100;
		this.y = 75;
		
		var message = "END !\n\n";
		message += "SCORE : " + score + "\n\n";
		
		var barre = new Bitmap(GameController.assets.getBitmapData("barre_score"));
		barre.x = 25;
		barre.y = 145;
		this.addChild(barre);
		
		var arrow = new Bitmap(GameController.assets.getBitmapData("arrow_score"));
		arrow.x = 60;
		arrow.y = 150;
		this.addChild(arrow);
		
		var positionArrow = score + 2000;
		if (positionArrow < 0) {
			positionArrow = 0;
		}
		if (positionArrow > 4000) {
			positionArrow = 4000;
		}
		
		arrow.x = positionArrow = 550 * (positionArrow / 4000) - 12 + 25; // -12, arrow width, 25 barre padding
		
		message += "Your boss : \n";
		
		if (score < 0 ) {
			message += '"Grrr ! Are you kindding me ?! I will sell you !"';
		} else if (score < 50 ) {
			message += '"MMmmhh ! Not enough ! I hope you will be better next time !"';
		} else {
			message += '"Good job ! You are priceless for the compagny !"';
		}
		
		this.displayMessage(message);
		
		close.defaultMessage.visible = false;
		close.shadowBottom.visible = false;
		close.shadowLeft.visible = false;
		close.shadowRight.visible = false;
		close.shadowTop.visible = false;
	}
	
}