package
{
	import com.feng.FUI;
	import com.junkbyte.console.Cc;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import modules.GameDispatcher;
	import modules.findpath.FindpathController;
	import modules.gamescene.GameScene;
	import modules.gamescene.GameSceneEvent;
	import modules.gamescene.data.PlayerModel;
	import modules.load.Load;
	import modules.mainView.MainView;
	import modules.moveaction.MoveActionController;

	/**
	 * 地图编辑器
	 * @author warden feng 2013-7-26
	 */
	[SWF(width = "1050", height = "700", frameRate = "30", backgroundColor = "0x000000")]
	public class FMapEditor extends Sprite
	{
		private var game:Game;

		public function FMapEditor()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}

		private function onAddToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			this.stage.tabChildren = false;
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			
			this.stage.addEventListener(Event.REMOVED_FROM_STAGE,function(event:Event):void
			{
				trace(event.target.name);
			});

			MyCC.initFlashConsole(this);
			GlobalData.logFunc = Cc.log;

			game = new Game();
			game.name = "game1";
			this.stage.addChild(game);
			
			UIAllRefer.stage = this.stage;

			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);

			FUI.init(stage);

			logger("客户端版本：" + GlobalData.VERSION);

			initMoudles();
		}

		protected function onMouseDown(event:MouseEvent):void
		{
			if (event.target.name == "MainUI")
			{
				NativeApplication.nativeApplication.activeWindow.startMove();
			}
		}

		/**
		 * 初始化模块
		 **/
		private function initMoudles():void
		{
//			MainView.init();

			Load.init();

			GameScene.init();

			//开启寻路模块
			FindpathController.start();

			//开启移动模块
			MoveActionController.start();

			var pkg:Object = {"result": 0, "hasPlayerId": true, "clothing": "10004", "hasUsername": true, "hP": 100, "mapId": 1001, "mP": 100, "hasMapX": true, "playerId": 436, "mapX": 27, "mapY": 64, "hasMapY": true, "username": "test436", "hasMP": true, "hasHP": true, "hasMapId": true, "hasClothing": true};

			GlobalData.username = pkg.username;
			GlobalData.roleX = pkg.mapX;
			GlobalData.roleY = pkg.mapY;
			GlobalData.roleId = pkg.playerId;
			GlobalData.mapId = pkg.mapId;

			var playerModel:PlayerModel = new PlayerModel();
			playerModel.playerId = pkg.playerId;
			playerModel.username = pkg.username;
			playerModel.mapX = pkg.mapX;
			playerModel.mapY = pkg.mapY;
			playerModel.mapId = pkg.mapId;
			playerModel.HP = pkg.hP;
			playerModel.MP = pkg.mP;
			GameData.playerDic[playerModel.playerId] = playerModel;

			dispatcher.dispatchEvent(new GameSceneEvent(GameSceneEvent.ADD_HERO, {mapX: pkg.mapX, mapY: pkg.mapY, clothing: pkg.clothing}));
		}
		
		private function get dispatcher():GameDispatcher
		{
			return GameDispatcher.instance;
		}
	}
}
