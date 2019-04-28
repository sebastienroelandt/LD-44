package ld.engine;
import lib.sro.engine.CollisionBox;
import lib.sro.layers.DrawableLayer;
import lib.sro.ui.constraint.IBasicUI;
import lib.sro.ui.impl.BasicUI;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import lib.sro.core.GameController;
import openfl.ui.Mouse;
/**
 * ...
 * @author Roelandt Sebastien
 */
class Sniper extends BasicUI
{
	var worldX : Float;
	var worldY : Float;
	var worldHeight : Float;
	var worldWidth : Float;
	
	var image : Bitmap;
	
	public function new (world: DrawableLayer) 
	{
		super();
		
		this.worldX = world.x;
		this.worldY = world.y;
		this.worldWidth = world.width;
		this.worldHeight = world.height;
		
		image = new Bitmap(GameController.assets.getBitmapData("sniper"));
		this.addChild(image);		
	}
	
	override public function update(delta:Float) {
		if (this.visible) {
			var position = lib.sro.input.Mouse.getXY();
			var displayMouse = false;
			
			var x = position.x - worldX - 24;
			if (x < 0) {
				x = 0;
				displayMouse = true;
			} else if (x > worldWidth - 48) {
				x = worldWidth - 48;
				displayMouse = true;
			} 
			
			var y = position.y - worldY - 24;
			if (y < 0) {
				y = 0;
				displayMouse = true;
			} else if (y > worldHeight - 48) {
				y = worldHeight - 48;
				displayMouse = true;
			}
			
			if (displayMouse) {
				Mouse.show();
			} else {
				Mouse.hide();
			}
			
			this.x = x;
			this.y = y;
		} else {
			Mouse.show();
		}
	}
	
	public function getCollisionBox() : CollisionBox {
		return new CollisionBox(this.x, this.y, image.height, image.width);
	}
	
	public function activate() {
		this.visible = true;
	}
	
	public function desactivate() {
		this.visible = false;
	}
	
	public function isActivated() : Bool {
		return this.visible;
	}
	
}