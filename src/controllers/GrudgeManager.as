package controllers {
	
	public class GrudgeManager {

		[Bindable]
		public var databaseController:Database;
		
		public function GrudgeManager() {
			trace("GrudgeManager loaded. Go team!");
		}
	
		//get all grudge targets
		public function getTargets():Array {
			var result:Array = databaseController.execSQL("select gt.id, gt.name, count(g.id) as totalgrudges from grudgetargets gt left join grudges g on g.targetidfk = gt.id group by gt.id");
			return result;
		}

	}
}