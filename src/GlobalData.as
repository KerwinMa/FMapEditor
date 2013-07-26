package
{

	/**
	 *
	 * @author warden feng 2013-5-28
	 */
	public class GlobalData
	{
		/** 版本号 */
		public static const VERSION:String = "2013.7.25 16:44";

		public static const rootPath:String = "http://localhost:8080/arpg/";

		public static const configPath:String = rootPath + "config.xml";

		public static var logFunc:Function;

		/** 地图块宽  */
		public static var MapTileWidth:int = 300;

		/** 地图块高  */
		public static var MapTileHeight:int = 300;
	}
}
