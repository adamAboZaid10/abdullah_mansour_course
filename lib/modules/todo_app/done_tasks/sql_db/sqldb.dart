import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqlDb
{
  static Database? _db;
 Future<Database?>  get db async
  {
    if(_db ==null)
      {
        _db = await initialDb();
        return _db;
      }
    else{
      return _db;
    }
  }
  initialDb()async
  {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath,'todo.db');
    Database mydb =await openDatabase(path,onCreate: _onCreate,version: 2,onUpgrade: _onUpgrade);
    return mydb;
  }
  _onUpgrade(Database db ,int oldVersion,int newVersion)
  {
    print('upgrade =========');
  }
  _onCreate(Database db ,int version)async
  {
    await db.execute('''
    CREATE TABLE "tasks"(
    "id" INTEGER PRIMARY KEY,
     "title" TEXT,
     "date" TEXT,"time" TEXT ,
      "status" TEXT
      )
    ''');
    print('onCreate =========');
  }
  readData(String sql)async
  {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }
  insertData(String sql)async
  {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }
  updateData(String sql)async
  {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }
  deleteData(String sql)async
  {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}
