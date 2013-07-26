package
{
	import com.feng.FUI;
	import com.junkbyte.console.Cc;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import modules.mainView.MainView;
	
	/**
	 * 
	 * @author warden feng 2013-7-26
	 */
	[SWF(width = "1050", height = "700", frameRate = "30", backgroundColor = "0x000000")]
	public class FMapEditor extends Sprite
	{
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
			
			MyCC.initFlashConsole(this);
			GlobalData.logFunc = Cc.log;
			
			UIAllRefer.stage = this.stage;
			UIAllRefer.game = this;
			FUI.init(stage);
			
			initLayers();

			logger("客户端版本：" + GlobalData.VERSION);
			
			initMoudles();
		}
		
		private function initLayers():void
		{
			UIAllRefer.backLayer.name = "backLayer";
			this.addChild(UIAllRefer.backLayer);
			UIAllRefer.sceneLayer.name = "sceneLayer";
			this.addChild(UIAllRefer.sceneLayer);
			UIAllRefer.contentLayer.name = "contentLayer";
			this.addChild(UIAllRefer.contentLayer);
			UIAllRefer.promptBoxLayer.name = "promptBoxLayer";
			this.addChild(UIAllRefer.promptBoxLayer);
			UIAllRefer.infoLayer.name = "infoLayer";
			this.addChild(UIAllRefer.infoLayer);
			UIAllRefer.tooltipLayer.name = "tooltipLayer";
			this.addChild(UIAllRefer.tooltipLayer);
		}
		
		/**
		 * 初始化模块
		 **/
		private function initMoudles():void
		{
			MainView.init();
		}
	}
}