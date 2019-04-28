package ld.core;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Assets;
import lib.sro.data.StatedAnimationData;
import lib.sro.core.ResourcesLoader;
import lib.sro.core.ResourcesStorage;
import ld.engine.TargetType;


/**
 * ...
 * @author Sebastien roelandt
 */
class MyResourcesLoader
{
	public static function load(rs:ResourcesStorage) {
		
		var messageBackground = Assets.getBitmapData("img/repetitiveBackground.png");
		var messageBackgroundSplited = ResourcesLoader.splitToBitmapData(messageBackground, 0, 0, 50, 50, 9, 1);
		rs.addTileset("messageBackground", messageBackgroundSplited);
		
		var target = new StatedAnimationData("target");
		//idle 
		var idle = Assets.getBitmapData("img/idle.png");
		target.addLinearFrames("idle", ResourcesLoader.splitToBitmapData(idle, 0, 0, 28, 28, 4, 1), 100);
		target.setLoop("idle", true); 
		//right
		var right = Assets.getBitmapData("img/right.png");
		target.addLinearFrames("right", ResourcesLoader.splitToBitmapData(right, 0, 0, 28, 28, 4, 1), 100);
		target.setLoop("right", true); 
		//left
		var left = Assets.getBitmapData("img/left.png");
		target.addLinearFrames("left", ResourcesLoader.splitToBitmapData(left, 0, 0, 28, 28, 4, 1), 100);
		target.setLoop("left", true); 
		rs.addStatedAnimationData("target", target); 
		
		var targetColors = TargetType.getAll();
		for (targetColor in targetColors) {
			var color = Assets.getBitmapData("img/" + targetColor + ".png");
			rs.addBitmapData(targetColor, color);
		}
		
		//sniper
		var sniper = Assets.getBitmapData("img/sniper.png");
		rs.addBitmapData("sniper", sniper);
		
		//coin
		var coin = Assets.getBitmapData("img/coin.png");
		rs.addBitmapData("coin", coin);
		
		//coin négatif
		var coin_negatif = Assets.getBitmapData("img/coin_negatif.png");
		rs.addBitmapData("coin_negatif", coin_negatif);
		
		//prison
		var prison = Assets.getBitmapData("img/prison.png");
		rs.addBitmapData("prison", prison);
		
		//prison destroyed
		var prison_destroyed = Assets.getBitmapData("img/prison_destroyed.png");
		rs.addBitmapData("prison_destroyed", prison_destroyed);
		
		//munitions
		var munition = Assets.getBitmapData("img/munition.png");
		rs.addBitmapData("munition", munition);
		
		//barre_score
		var barre_score = Assets.getBitmapData("img/barre_score.png");
		rs.addBitmapData("barre_score", barre_score);
		
		//arrow_score
		var arrow_score = Assets.getBitmapData("img/arrow_score.png");
		rs.addBitmapData("arrow_score", arrow_score);
	}
	
}