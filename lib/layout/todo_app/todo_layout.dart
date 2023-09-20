import 'package:flutter/material.dart';
import 'package:oneproject/modules/todo_app/done_tasks/archive_tasks/archive_tasks_screen.dart';
import 'package:oneproject/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:oneproject/modules/todo_app/done_tasks/new_tasks/new_tasks_screen.dart';
import 'package:oneproject/modules/todo_app/done_tasks/sql_db/sqldb.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchiveTasksScreen(),
  ];
  SqlDb sqldb = new SqlDb();
  Future<List<Map>> readData() async
  {
    List<Map> response = await sqldb.readData("SELECT * FROM tasks");
    return response;
  }
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(titles[currentIndex]),
      ),
      body:screens[currentIndex] ,
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        async{
          var name =await getName();
          print(name);
        },
        child:const Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'done',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: 'archived',
          ),
        ],
      ),
    );
  }
  Future<String> getName()async
  {
     return 'abdo';
  }
}


/*
import 'package:flutter/material.dart';
import 'package:oneproject/modules/archive_tasks/archive_tasks_screen.dart';
import 'package:oneproject/modules/done_tasks/done_tasks_screen.dart';
import 'package:oneproject/modules/new_tasks/new_tasks_screen.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> screens =
  [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchiveTasksScreen(),
  ];
  List<String> titles =
  [
    'New Tasks',
    'Done tasks',
    'Archive tasks',
  ];
  @override
  void initState() {
    super.initState();
    createDataBase();
  }
  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheetShow = false;
  IconData fabIcon =Icons.edit;
  var titleController =TextEditingController();
  var timeController =TextEditingController();
  var dateController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title:  Text(
            titles[currentIndex],
        ),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          if(isBottomSheetShow)//=false
          {
            Navigator.pop(context);
            isBottomSheetShow =false;
            setState(() {
              fabIcon = Icons.edit;
            });
          }
          else
          {
            scaffoldKey.currentState!.showBottomSheet((context) => Column(
              mainAxisSize: MainAxisSize.min,
              children:
              [
                TextFormField(
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  validator: (String? value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'the title must not be empty';
                    }return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'task title',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.task,
                    ),
                  ),
                  onTap:()
                  {
                    print('title tapped');
                  },
                ),
              ],
            ),
            );
            isBottomSheetShow = true;
            setState(() {
              fabIcon = Icons.add;
            });
          }
        },
        child:Icon(
          fabIcon,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index)
        {
          setState(() {
            currentIndex = index;
          });
        },
        items:
        const[
          BottomNavigationBarItem(
              icon:Icon(
                Icons.menu,
              ),
            label: 'tasks',
          ),
          BottomNavigationBarItem(
              icon:Icon(
                Icons.check_circle,
              ),
            label: 'Done',
          ),
          BottomNavigationBarItem(
              icon:Icon(
                Icons.archive_outlined,
              ),
            label: 'archive',
          ),
        ],
      ),
    );
  }
  // Future<String> getName()async
  // {
  //   return 'Adammo';
  // }
  void createDataBase()async
  {
     database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database,version)
      {
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT ,date TEXT,time TEXT ,status TEXT)').then((value){
          print('table created');
        }).catchError((error)
        {
          print(error.toString());
        });
        print('database created');
      },
      onOpen: (database)
      {
         print('database opened');
      }
    );
  }
  void insertDataBase()
  {
    database.transaction((txn){
      return txn.rawInsert('INSERT INTO tasks (title ,date,time ,status) VALUES ("FIRST task" ,"22","122","new")').then((value){
        print('$value inserted successfully');
      }).catchError((error){
        print(error.toString());
      });

    });
  }
}*/

