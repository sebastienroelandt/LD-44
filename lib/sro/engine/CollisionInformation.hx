package lib.sro.engine;
import openfl.geom.Point;

/**
 * ...
 * @author Sebastien roelandt
 */
class CollisionInformation {
	var isCollision : Bool;
	var isRightCollision: Bool;
	var isLeftCollision: Bool;
	var isUpCollision: Bool;
	var isDownCollision: Bool;
	var calculatedX : Float;
	var calculatedY : Float;
	
	public function new() {
		this.isCollision = false;
		this.isRightCollision = false;
		this.isLeftCollision = false;
		this.isUpCollision = false;
		this.isDownCollision = false;
		this.calculatedX = 0;
		this.calculatedY = 0;
	}
	
	public function setIsCollision(isCollision : Bool) {
		this.isCollision = isCollision;
	}

	public function getIsCollision() : Bool {
		return this.isCollision;
	}
	
	public function setIsRightCollision(isRightCollision : Bool) {
		this.isRightCollision = isRightCollision;
	}

	public function getIsRightCollision() : Bool {
		return this.isRightCollision;
	}

	public function setIsLeftCollision(isLeftCollision : Bool) {
		this.isLeftCollision = isLeftCollision;
	}

	public function getIsLeftCollision() : Bool {
		return this.isLeftCollision;
	}

	public function setIsDownCollision(isDownCollision : Bool) {
		this.isDownCollision = isDownCollision;
	}

	public function getIsDownCollision() : Bool {
		return this.isDownCollision;
	}

	public function setIsUpCollision(isUpCollision : Bool) {
		this.isUpCollision = isUpCollision;
	}

	public function getIsUpCollision() : Bool {
		return this.isUpCollision;
	}

	public function setCalculatedX(calculatedX : Float) {
		this.calculatedX = calculatedX;
	}

	public function getCalculatedX() : Float {
		return this.calculatedX;
	}

	public function setCalculatedY(calculatedY : Float) {
		this.calculatedY = calculatedY;
	}

	public function getCalculatedY() : Float {
		return this.calculatedY;
	}

}