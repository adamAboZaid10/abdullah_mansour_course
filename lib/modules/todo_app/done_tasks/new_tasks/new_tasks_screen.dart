// import 'package:flutter/material.dart';
// import 'package:oneproject/shared/components/components.dart';
// import 'package:oneproject/shared/components/constants.dart';
//
// class NewTasksScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//         itemBuilder:  ( context , index) => buildTaskItem(),
//         separatorBuilder: (context , index) => Padding(
//           padding: const EdgeInsetsDirectional.only(
//             start: 20,
//           ),
//           child: Container(
//             color: Colors.grey[300],
//             width: double.infinity,
//             height: 1.0,
//           ),
//         ),
//         itemCount: tasks.length,
//     );
//   }
// }
import 'package:flutter/material.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  const Center(
      child: Text (
        'New Tasks',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
