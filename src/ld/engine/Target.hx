package ld.engine;
import flash.display.Bitmap;
import lib.sro.engine.CollisionBox;
import lib.sro.entity.impl.MovableEntity;
import lib.sro.core.GameController;
import lib.sro.entity.process.impl.FrictionProcess;
import lib.sro.layers.DrawableLayer;
import lib.sro.core.Bresenham;
import lib.sro.engine.CollisionUtils; 
import openfl.geom.Point;

/**
 * ...
 * @author Roelandt Sebastien
 */

class Target extends MovableEntity
{
	private static var FRICTION = 0.7;
	
	private static var OSCILATION = 0.2;
	private static var OSCILATION_TIME = 150;
	
	var targetType: String;
	var worldHeight : Float;
	var worldWidth : Float;
	
	var colorBitmap : Bitmap;
	
	// idle
	var idleTimer : Float;
	var isIdle : Bool;
	
	// Mouvement
	var destination: {x: Int, y: Int};
	var speed: Float;
	
	//End
	var isKilled : Bool;
	var isEnd : Bool;
	var endTimer : Float;
	var isRunning : Bool;
	
	public function new(targetType: String, world: DrawableLayer) 
	{
		super(GameController.assets.getStatedAnimationData("target"));
		
		this.targetType = targetType;
		var color = GameController.assets.getBitmapData(targetType);
		colorBitmap = new Bitmap(color);
		this.addChildAt(colorBitmap, 0);
		
		this.addProcess(new FrictionProcess(this, FRICTION, FRICTION));
		this.addProcess(new OscillationProcess(this, OSCILATION, OSCILATION_TIME));
		
		this.worldHeight = world.height;
		this.worldWidth = world.width;
		
		var position = calculateNextPosition();
		setXx(position.x);
		setYy(position.y);
		
		this.idleTimer = calculateIdleTime();
		this.idleTimer -= 2500; //On fait demarrer la moitée des targets
		this.isIdle = true;
		this.change("idle");
		
		this.speed = calculateSpeed();
		this.isKilled = false;
	}
	
	private function calculateNextPosition() : {x: Int, y: Int} {
		var maxX =  this.worldWidth - 28;
		var maxY =  this.worldHeight - 28;
		
		return {
			x: Std.random(Std.int(maxX)),
			y: Std.random(Std.int(maxY))
		};
	}
	
	private function calculateIdleTime() : Float {
		//Temps d'attente entre 1 et 5 secondes
		return 1000 + Std.random(4000); 
	}
	
	private function calculateSpeed() : Float {
		return 1 - Std.random(5) * 0.1; // Entre 1 et 0.6
 	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		if (!isKilled) {
			if (isEnd) {
				endTimer -= delta;
				if (endTimer <= 0){
					endTimer = 0;
					if (!isRunning) {
						isIdle = false;
						changeAnimation();
						isRunning = true;
					} else {
						if (getXx() - destination.x > 0) {
							// Droite
							dx -= speed * 2;
						} else {
							dx += speed * 2;
						}
						if (this.getXx() < 0 || this.getXx() > worldWidth - 28 * 2) {
							isKilled = true;
							this.visible = false;
						}
					}
				}
			} else if (isIdle) {
				idleTimer -= delta;
				if (idleTimer < 0) {
					// Fin du idle
					isIdle = false;
					idleTimer = calculateIdleTime();
					destination = calculateNextPosition();
					speed = calculateSpeed();
					changeAnimation();
				}
			} else {
				//La destination est atteinte
				if (Bresenham.fastAbs(Std.int(destination.x - this.getXx())) < 5 
					&& Bresenham.fastAbs(Std.int(destination.y - this.getYy())) < 5) {
					isIdle = true;
					changeAnimation();
				} else {
					var mouvement = Bresenham.getMouvement(speed, {x: this.getXx(), y: this.getYy()}, {x: destination.x, y: destination.y});
					dx += mouvement.x;
					dy += mouvement.y;
				}
			}
		}
	}
	
	private function changeAnimation() {
		if (isIdle) {
			this.change("idle");
		} else {
			if (getXx() - destination.x > 0) {
				// Vers la gauche
				change("left");
			} else {
				// Vers la droite
				change("right");
			}
		}
	}
	
	public function getIdle(): Bool {
		return isIdle;
	}
	
	public function isCollideWith(box: CollisionBox) {
		return CollisionUtils.isPointInBox(box, new Point(getXx() + 14, getYy() + 14));
	}
	
	public function kill() {
		this.isKilled = true;
		isIdle = true;
		changeAnimation();
	}
	
	public function getIsKilled(): Bool {
		return this.isKilled;
	}
	
	public function end() {
		if (!isEnd) { //Si la fin n'a pas encore été prise en compte
			isEnd = true;
			isIdle = true;
			endTimer = 2000;
			changeAnimation();
			isRunning = false;
			if (Std.random(2) == 0) { 
				destination = {x: 0, y: Std.int(this.getYy())};
			} else {
				destination = {x: 800, y: Std.int(this.getYy())};
			}
		}
	}
	
	public function getColor(): String {
		return this.targetType;
	}
	
	public function displayProfil() {
		
	}
	
	public function changeIdleTimer(idleTimer: Float) {
		this.idleTimer = idleTimer;
		this.isIdle = true;
		changeAnimation();
	}
}