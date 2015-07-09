package
{
	import com.mcc.layout.AlignMode;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;

	public class ImageInjector
	{
		public static function inject(sprite:Sprite, bitmapClass:Class, align:String = AlignMode.ALIGN_TOP_LEFT):Sprite{
			var img:Bitmap = Assets.getBackground(bitmapClass);
			switch(align){
				case AlignMode.ALIGN_CENTER:
					img.x = -img.width*.5;
					img.y = -img.height*.5;
					break;
			}
			
			sprite.addChild(img);
			
			return sprite;
		}
	}
}