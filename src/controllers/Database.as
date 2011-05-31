package controllers {

	import flash.data.SQLConnection; 
	import flash.events.SQLErrorEvent; 
	import flash.events.SQLEvent; 
	import flash.filesystem.File;

	public class Database {

		public function Database() {
			trace("database controller initialized");
			var folder:File = File.applicationStorageDirectory; 
			var dbFile:File = folder.resolvePath("grudge.db");

			//initial connection handles DB setup so it's not async
			var conn:SQLConnection = new SQLConnection();
			conn.open(dbFile); 
			trace("database opened for initial setup SQL");
			
			//do stuff
			conn.close();
			trace("database closed for initial setup SQL");
			
		}

	}

}