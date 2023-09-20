import 'package:flutter/material.dart';

class BmiResult extends StatelessWidget {
  final bool? gender ;
  final double? result;
  final int? age;
  const BmiResult({Key? key,
   @ required this.gender,
   @ required this.result,
   @ required this.age,
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'BMI Result',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Column(

          //mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Gender : $gender',
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Result : ${result!.round()}',
                    style:const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Age : $age',
                    style:const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
             Image(
                 image: NetworkImage('https://www.calculatorsoup.com/images/health/WHO-BMI-chart-for-adults.png')),
          ],
        ),
      ),
    );
  }
}