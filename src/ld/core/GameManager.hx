package ld.core;

import ld.screen.GameScreen;
import lib.sro.core.GameController;
import lib.sro.core.ResourcesStorage;
import lib.sro.screen.Screen;
import lib.sro.layers.DrawableLayer;
import lib.sro.ui.impl.TiledMapUI;
import lib.sro.core.Bresenham;
import openfl.display.Sprite;

/**
 * ...
 * @author Sebastien roelandt
 */
class GameManager extends GameController
{
	
	private var gameScreen : Screen;
	
	public function new()
	{
		super();
		
		loadAssets();
		displayGameScreen();
		
		start();
	}
	
	private function loadAssets() {
		var assets = ResourcesStorage.getInstance();
		MyResourcesLoader.load(assets);
		GameController.assets = assets;
	}
	
	private function displayGameScreen() {
		this.gameScreen = new GameScreen();
		this.addScreen(this.gameScreen);
	}
}