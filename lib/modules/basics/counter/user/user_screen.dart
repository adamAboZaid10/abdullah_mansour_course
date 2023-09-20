import 'package:flutter/material.dart';
import 'package:oneproject/models/user/user_model.dart';
class usersScreen extends StatelessWidget {
  List<Model> users=
  [
    Model(
        id: 1,
        name: 'abdo',
        phone: '010218789225',
        ),
    Model(
        id: 2,
        name: 'mohamed',
        phone: '01024455825',
        ),
    Model(
        id: 3,
        name: 'AMR',
        phone: '01284030681',
        ),
    Model(
      id: 1,
      name: 'abdo',
      phone: '010218789225',
    ),
    Model(
      id: 2,
      name: 'mohamed',
      phone: '01024455825',
    ),
    Model(
      id: 3,
      name: 'AMR',
      phone: '01284030681',
    ),
    Model(
      id: 1,
      name: 'abdo',
      phone: '010218789225',
    ),
    Model(
      id: 2,
      name: 'mohamed',
      phone: '01024455825',
    ),
    Model(
      id: 3,
      name: 'AMR',
      phone: '01284030681',
    ),
    Model(
      id: 1,
      name: 'abdo',
      phone: '010218789225',
    ),
    Model(
      id: 2,
      name: 'mohamed',
      phone: '01024455825',
    ),
    Model(
      id: 3,
      name: 'AMR',
      phone: '01284030681',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'Users',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context,index)=>buildUser(users[index]),
          separatorBuilder: (context,index)=>Container(
            color: Colors.grey,
            width: double.infinity,
            height: 1.0,
          ),
          itemCount: users.length,
      ),
    );
  }
  Widget buildUser(Model user)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            const CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.blue,
            ),
            Text(
              '${user.id}',
              style:const TextStyle(
                fontSize: 25,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children:
          [
            Text(
              '${user.name}',
              style:const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              user.phone,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}
