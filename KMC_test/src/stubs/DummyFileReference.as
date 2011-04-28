package stubs
{
	import flash.net.FileReference;
	
	public class DummyFileReference extends FileReference {
		
		public function DummyFileReference()
		{
			super();
		}
		
		
		private var _size:uint;
		
		override public function get size():uint {
			return _size;
		}
		
		public function set size(value:uint):void {
			_size = value;
		}
	}
}