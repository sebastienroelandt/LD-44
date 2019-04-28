package lib.sro.core;

import lib.sro.entity.constraint.IBasicEntity;
import openfl.display.Sprite;
import openfl.geom.Matrix;
import openfl.geom.Point;

/**
 * ...
 * @author Sebastien roelandt
 */
class Transformation
{

	public static function rotateRad(entity:IBasicEntity, pivot:Point, angleInRadians:Float) 
	{
		//Move to translation point
		var matrix:Matrix = new Matrix();
		
		matrix.tx -= pivot.x;
		matrix.ty -= pivot.y;

		//Calculate 
		var sin = Math.sin(angleInRadians);
		var cos = Math.cos(angleInRadians);
		var a = matrix.a;
		var b = matrix.b;
		var c = matrix.c;
		var d = matrix.d;
		var tx = matrix.tx;
		var ty = matrix.ty;
		matrix.a = a*cos - b*sin;
		matrix.b = a*sin + b*cos;
		matrix.c = c*cos - d*sin;
		matrix.d = c*sin + d*cos;
		matrix.tx = tx*cos - ty*sin;
		matrix.ty = tx*sin + ty*cos;

		//Restore the translation
		matrix.tx += pivot.x + entity.getXx();
		matrix.ty += pivot.y + entity.getYy();

		entity.getSprite().transform.matrix = matrix;	

	}
	
	public static function rotateDegree(entity:IBasicEntity, pivot:Point, angleInDegrees:Float) 
	{
		rotateRad(entity, pivot, angleInDegrees * Math.PI / 180);
	}
	
}