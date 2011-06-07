package controllers {

	import flash.data.SQLConnection; 
	import flash.events.SQLErrorEvent; 
	import flash.events.SQLEvent; 
	import flash.data.SQLStatement;
	import flash.data.SQLResult;
	import flash.filesystem.File;

	public class Database {

		protected var mainConn:SQLConnection = new SQLConnection();

		public function Database() {
			trace("database controller initialized");
			var folder:File = File.applicationStorageDirectory; 
			var dbFile:File = folder.resolvePath("grudge.db");
			
			//initial connection handles DB setup so it's not async
			var conn:SQLConnection = new SQLConnection();
			conn.open(dbFile); 
			trace("database opened for initial setup SQL - location is "+dbFile.nativePath);
			
			//do our setup

			//grudgetargets are the people we have grudges against. I'm using a generic
			//"target" since you may want to have a grudge against something vague like, oh,
			//the world at large
			var createStmt:SQLStatement = new SQLStatement(); 
			createStmt.sqlConnection = conn; 
	
			var sql:String =  
				"CREATE TABLE IF NOT EXISTS grudgetargets (" +  
				"    id INTEGER PRIMARY KEY AUTOINCREMENT, " +  
				"    name TEXT " +  
				")"; 
			createStmt.text = sql; 
			createStmt.execute();
			
			//grudges are the actual things that pissed you off. They have a FK to the
			//target and a create date
			sql =  
				"CREATE TABLE IF NOT EXISTS grudges (" +  
				"    id INTEGER PRIMARY KEY AUTOINCREMENT, " +  
				"    reason TEXT, " +  
				"    targetidfk INTEGER, " +
				"    created DATE " +
				")"; 
			createStmt.text = sql; 
			createStmt.execute();

			conn.close();
			trace("database closed for initial setup SQL");
						
			//create a new connection for normal operations
			mainConn.open(dbFile);
			
		}
		
		public function execSQL(sql:String):Array {
			trace("execSQL: "+sql);
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection=mainConn;
			statement.text=sql;
			statement.execute();
			var sqlresult:SQLResult = statement.getResult();
			trace("Result size is "+sqlresult.data.length);
			return sqlresult.data;
		}

	}

}