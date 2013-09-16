package modules.mainView
{
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import fla.icon.DockImage;
	import fla.ui.MainUI;

	import modules.ViewManager;

	import utils.PopupManager;


	/**
	 *
	 * @author warden feng 2013-7-26
	 */
	public class MainViewManager extends ViewManager
	{
		private var mainUI:MainUI;

		public function MainViewManager()
		{
			super();

			init();

			initForDock();
		}

		override protected function init():void
		{
			mainUI = new MainUI();
			mainUI.name = "MainUI";

			mainUI.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			mainUI.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);

			show();
		}

		override protected function show():void
		{
			PopupManager.addPopUp(mainUI, UIAllRefer.stage);
		}

		override protected function onAddToStage(event:Event):void
		{
			mainUI.minimizeBtn.addEventListener(MouseEvent.CLICK, onClick);
			mainUI.maximizeBtn.addEventListener(MouseEvent.CLICK, onClick);
			mainUI.closeBtn.addEventListener(MouseEvent.CLICK, onClick);
		}

		protected function onClick(event:MouseEvent):void
		{
			switch (event.currentTarget)
			{
				case mainUI.minimizeBtn:
					dock();
					break;
				case mainUI.maximizeBtn:

					break;
				case mainUI.closeBtn:
					UIAllRefer.stage.nativeWindow.close();
					break;
			}
		}

		private var dockImage:DockImage = new DockImage(32, 32);

		public function initForDock():void
		{
			if (NativeApplication.supportsSystemTrayIcon)
			{
				var systemTrayIcon:SystemTrayIcon = SystemTrayIcon(NativeApplication.nativeApplication.icon);
				systemTrayIcon.tooltip = "地图编辑器";
				SystemTrayIcon(NativeApplication.nativeApplication.icon).addEventListener(MouseEvent.CLICK, undock);
			}
		}

		public function dock():void
		{
			UIAllRefer.stage.nativeWindow.visible = false; //set App is invisible
			NativeApplication.nativeApplication.icon.bitmaps = [dockImage]; //set dock's icon
		}

		public function undock(evt:Event):void
		{
			UIAllRefer.stage.nativeWindow.visible = true; //set App is visible 
			UIAllRefer.stage.nativeWindow.orderToFront(); //set App to front
			NativeApplication.nativeApplication.icon.bitmaps = []; //clear the icon of dock
		}
	}
}
