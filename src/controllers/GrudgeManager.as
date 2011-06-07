package controllers {
	
	public class GrudgeManager {

		[Bindable]
		public var databaseController:Database;
		
		public function GrudgeManager() {
			trace("GrudgeManager loaded. Go team!");
		}
	
		//get all grudge targets
		public function getTargets():Array {
			var result:Array = databaseController.execSQL("select * from grudgetargets");
			return result;
		}

	}
}