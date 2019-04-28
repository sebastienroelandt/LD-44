package ld.ui;

import flash.display.Bitmap;
import lib.sro.ui.constraint.IBasicUI;
import lib.sro.ui.impl.BasicUI;
import lib.sro.core.GameController;

/**
 * ...
 * @author Roelandt Sebastien
 */
class AdjustableBackground extends BasicUI
{

	public function new(assetId: String, width: Float, height: Float)
	{
		super(null);
		
		var bitmaps = GameController.assets.getTileset("messageBackground");
		
		var blockWidth = bitmaps[0].width;
		var blockHeight = bitmaps[0].height;

		var gridX = Std.int(width / blockWidth);
		var gridY = Std.int(height / blockHeight);
		for (i in 0...gridX) {
			for (y in 0...gridY) {
				var block;
				if (y == 0) {
					// First row
					if (i == 0) {
						// Top left corner
						block = new Bitmap(bitmaps[0]);
					} else if (i == gridX - 1) {
						// Top right corner
						block = new Bitmap(bitmaps[1]);
					} else {
						// Top border
						block = new Bitmap(bitmaps[4]);
					}
				} else if (y == gridY - 1) {
					// Last row
					if (i == 0) {
						// Bottom left corner
						block = new Bitmap(bitmaps[3]);
					} else if (i == gridX - 1) {
						// Bottom right corner
						block = new Bitmap(bitmaps[2]);
					} else {
						// Bottom border
						block = new Bitmap(bitmaps[6]);
					}
				} else {
					if (i == 0) {
						// Left Border
						block = new Bitmap(bitmaps[7]);
					} else if (i == gridX - 1) {
						// Right Border
						block = new Bitmap(bitmaps[5]);
					} else {
						// Bottom border
						block = new Bitmap(bitmaps[8]);
					}
				}
				block.x = i * blockWidth;
				block.y = y * blockHeight;
				this.addChild(block);
			}
		}
		
		
	}
	
}