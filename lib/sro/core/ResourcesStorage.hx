package lib.sro.core;

import lib.sro.core.ResourcesStorage;
import lib.sro.data.StatedAnimationData;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.media.Sound;

/**
 * ...
 * @author Sebastien roelandt
 */
class ResourcesStorage
{
	///Instance
	private static var instance:ResourcesStorage;
		
	private var statedAnimationDatas:Map<String,StatedAnimationData>;
	private var bitmaps:Map<String, BitmapData>;
	private var tilesets:Map<String, Array<BitmapData>>;
	private var tilemapValues:Map<String, Array<Array<Int>>>;
	private var sounds:Map<String, Sound>;
	
	public static function getInstance():ResourcesStorage {
		if (instance == null) {
			instance = new ResourcesStorage();
		}
		return instance;
	}
	
	private function new() {
		statedAnimationDatas = new Map();
		bitmaps = new Map();
		tilesets = new Map();
		tilemapValues = new Map();
		sounds = new Map();
	}
	
	public function getStatedAnimationData(name:String):StatedAnimationData {
		return statedAnimationDatas.get(name);
	}
	
	public function addStatedAnimationData(name:String, spritesheet:StatedAnimationData) {
		return statedAnimationDatas.set(name, spritesheet);
	}
	
	public function getBitmapData(name:String):BitmapData {
		return bitmaps.get(name);
	}
	
	public function addBitmapData(name:String, bitmap:BitmapData) {
		return bitmaps.set(name, bitmap);
	}
	
	public function getTileset(name:String):Array<BitmapData> {
		return tilesets.get(name);
	}
	
	public function addTileset(name:String, tileset:Array<BitmapData>) {
		return tilesets.set(name, tileset);
	}
	
	public function getTilemapValues(name:String):Array<Array<Int>> {
		return tilemapValues.get(name);
	}
	
	public function addTilemapValues(name:String, values:Array<Array<Int>>) {
		return tilemapValues.set(name, values);
	}
	
	public function getSound(name:String):Sound {
		return sounds.get(name);
	}
	
	public function addSound(name:String, values:Sound) {
		return sounds.set(name, values);
	}
}