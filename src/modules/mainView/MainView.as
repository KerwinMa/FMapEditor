package modules.mainView
{
	/**
	 * 
	 * @author warden feng 2013-7-26
	 */
	public class MainView
	{
		private static var mainViewManager:MainViewManager;
		
		public static function init():void
		{
			mainViewManager || (mainViewManager = new MainViewManager());
		}
	}
}