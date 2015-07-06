package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;

	public class ImageInjector
	{
		public static function inject(sprite:Sprite, bitmapClass:Class):Sprite{
			var img:Bitmap = Assets.getBackground(bitmapClass);
			sprite.addChild(img);
			return sprite;
		}
	}
}