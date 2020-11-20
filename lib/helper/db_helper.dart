import 'package:todo/models/task.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper{
	static Database _db;
	static final int _version = 2;
	static final String _tableName_1 = 'notes';
	static final String _tableName_2 = 'taks';


	static Future<void> initDb() async {
		if(_db != null){
			return;
		}

		try{
			Directory documentsDirectory = await getApplicationDocumentsDirectory();
    		String _path = join(documentsDirectory.path, "todos.db");
    		print(_path);
    		// await deleteDatabase(_path);
			_db = await openDatabase(
				_path,
				version: _version,
				onCreate: (db, version) async {
					await db.execute(
						"CREATE TABLE $_tableName_1 ( id integer PRIMARY KEY autoincrement, id_task integer, name TEXT, checked integer, created_at TEXT);"
				    );
				    await db.execute(
						"CREATE TABLE $_tableName_2 (id integer PRIMARY KEY autoincrement, name TEXT, color_task integer,icon_task integer);"
				    );
				}
			); 
		} catch(e){
			print("error");
			print(e);
		}
	}

	static Future<int> note_insert(CheckTask checkTask) async => 
		await _db.insert(_tableName_1, checkTask.toJson());

	static Future<int> note_update(CheckTask checkTask) async => 
		await _db.update(_tableName_1, checkTask.toJson(), where: 'id = ?', whereArgs:[checkTask.id]);	

	static 	Future<int> note_delete(CheckTask checkTask) async =>
		await _db.delete(_tableName_1, where: 'id = ?', whereArgs: [checkTask.id]);

	static Future<List<Map<String, dynamic>>> note_getbyid(int id_task) async => await _db.query(
		_tableName_1, 
		where: 'id_task = ?', 
		whereArgs: [id_task]
	); 

	static Future<List<Map<String, dynamic>>> note_today(String todayDate) async => await _db.rawQuery("SELECT * FROM $_tableName_1 WHERE created_at = ?",[todayDate]);

	static Future<List<Map<String, dynamic>>> note_getall() async => await _db.query(_tableName_1); 


	static Future<int> task_insert(Task task) async => 
		await _db.rawInsert("INSERT INTO $_tableName_2 (name, color_task, icon_task) VALUES (?,?,?)", [task.name, task.color, task.icon]);

	static Future<int> task_update(Task task) async => 
		await _db.update(_tableName_2, task.toJson(), where: 'id = ?', whereArgs:[task.id]);	

	static 	Future<int> task_delete(Task task) async =>
		await _db.delete(_tableName_2, where: 'id = ?', whereArgs: [task.id]);

	static Future<List<Map<String, dynamic>>> task_getall() async => await _db.rawQuery("SELECT t.*, SUM(CASE WHEN n.checked = '1' THEN 1 ELSE 0 END) as count_checked, SUM(CASE WHEN n.checked = '0' THEN 1 ELSE 0 END) as count_unchecked, COUNT(n.id) as count_all FROM $_tableName_2 as t LEFT JOIN $_tableName_1 as n ON t.id = n.id_task GROUP BY t.id, t.name");

	static Future<Task> task_getbyid(int id) async {
		 List<Map> tasks = await _db.rawQuery("SELECT t.*, SUM(CASE WHEN n.checked = '1' THEN 1 ELSE 0 END) as count_checked, SUM(CASE WHEN n.checked = '0' THEN 1 ELSE 0 END) as count_unchecked, COUNT(n.id) as count_all FROM $_tableName_2 as t LEFT JOIN $_tableName_1 as n ON t.id = n.id_task GROUP BY t.id, t.name HAVING t.id = ?", [id]);
		if (tasks.length > 0) {
	      return Task.fromJson(tasks.first);
	    }
	    return null;
	} 

	 

	Future close() async => _db.close();
}