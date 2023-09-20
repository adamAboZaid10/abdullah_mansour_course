import 'package:flutter/material.dart';
import 'package:oneproject/modules/todo_app/done_tasks/sql_db/sqldb.dart';

class testData extends StatelessWidget {
  SqlDb sqlDb = SqlDb();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HomePage',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:
            [
              Container(
                color: Colors.red,
                child: TextButton(
                  onPressed: ()async{
                    int reponse = await sqlDb.insertData(
                        "INSERT INTO 'notes' ('note') VALUES ('not two')");
                    print(reponse);
                  },
                  child:const Text(
                    'insertData',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ) ,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.red,
                child: TextButton(
                    onPressed: ()async{
                     List<Map> respone= await sqlDb.readData("SELECT * FROM 'notes'");
                     print(respone);
                     },
                    child:const Text(
                      'ReadData',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ) ,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.red,
                child: TextButton(
                    onPressed: ()async{
                     int respone= await sqlDb.deleteData("DELETE FROM 'notes' WHERE id =1");
                     print(respone);
                     },
                    child:const Text(
                      'DeleteData',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ) ,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
