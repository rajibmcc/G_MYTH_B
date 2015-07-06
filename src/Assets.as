package 
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;

	public class Assets
	{
		[Embed(source="../assets/images/forest_home.png")]
		public static var IMG_forestHome:Class;
		
		[Embed(source="../assets/images/forest_snake.png")]
		public static var IMG_forestSnake:Class;
		
		[Embed(source="../assets/images/forest_snake2.png")]
		public static var IMG_forestSnake2:Class;
		
		[Embed(source="../assets/images/femaleRS_01.png")]
		public static var IMG_jigFR01:Class;
		
		[Embed(source="../assets/images/femaleRS_02.png")]
		public static var IMG_jigFR02:Class;
		
		[Embed(source="../assets/images/femaleRS_03.png")]
		public static var IMG_jigFR03:Class;
		
		[Embed(source="../assets/images/femaleRS_04.png")]
		public static var IMG_jigFR04:Class;
		
		[Embed(source="../assets/images/femaleReproductiveSystem.png")]
		public static var IMG_jigFR:Class;
		
		[Embed(source="../assets/images/forest_elephant.png")]
		public static var IMG_forestElephant:Class;
		
		[Embed(source="../assets/images/forest_elephantZoom.png")]
		public static var IMG_forestElephant2:Class;
		
		[Embed(source="../assets/images/forest_tiger.png")]
		public static var IMG_forestTiger:Class;
		[Embed(source="../assets/images/forest_tiger_bush01.png")]
		public static var IMG_forestTigerBush01:Class;
		[Embed(source="../assets/images/forest_tiger_bush02.png")]
		public static var IMG_forestTigerBush02:Class;
		[Embed(source="../assets/images/forest_tiger_tree01.png")]
		public static var IMG_forestTigerTre01:Class;
		[Embed(source="../assets/images/forest_tiger_tree02.png")]
		public static var IMG_forestTigerTre02:Class;
		[Embed(source="../assets/images/tiger_hide_head.png")]
		public static var IMG_forestTigerHead:Class;
		[Embed(source="../assets/images/tiger_hide_tail.png")]
		public static var IMG_forestTigerTail:Class;
		[Embed(source="../assets/images/cubFull.png")]
		public static var IMG_forestTigerCub:Class;
		[Embed(source="../assets/images/tiger.png")]
		public static var IMG_Tiger:Class;
		[Embed(source="../assets/images/ico_tigerGray.png")]
		public static var IMG_TigerIconGray:Class;
		[Embed(source="../assets/images/ico_tiger.png")]
		public static var IMG_TigerIcon:Class;
		
		[Embed(source="../assets/images/forest_monkey_interactive.png")]
		public static var IMG_MONKEY_INTERACTIVE:Class;
		[Embed(source="../assets/images/forest_monkey.png")]
		public static var IMG_forest_monkey:Class;
		[Embed(source="../assets/images/forest_monkey_far.png")]
		public static var IMG_forest_monkey_far:Class;
		[Embed(source="../assets/images/forest_bird.png")]
		public static var IMG_forest_bird:Class;
		
		
		
		private static var backgrounds:Dictionary = new Dictionary();
		
		public static function getBackground(key:Class):Bitmap{
			/*if(backgrounds[key] == undefined){
				trace("Generating for the first time");
				backgrounds[key] = new key();
				return backgrounds[key];
			}
			
			return backgrounds[key];*/
			
			return new key();
		}
	}
}