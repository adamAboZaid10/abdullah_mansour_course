import 'dart:math';

import 'package:flutter/material.dart';
import 'package:oneproject/modules/bmi_screens/bmi_result/bmi_reslut_screen.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}
class _BmiScreenState extends State<BmiScreen> {
  bool isMale = true;
  double height =120;
  int weight = 60;
  int age = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'BMI Calculator',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children:
        [
          Expanded(
            child:Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children:
                [
                  Expanded(
                    child: GestureDetector(
                      onTap: ()
                      {
                        setState(() {
                          isMale = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isMale? Colors.blue: Colors.grey[400],
                          borderRadius: BorderRadiusDirectional.circular(10),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Image(
                              image: AssetImage(
                                'assets/images/male.jpeg'),
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Male',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: ()
                      {
                       setState(() {
                         isMale = false;
                       });

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isMale?Colors.grey[400]:Colors.blue,
                          borderRadius: BorderRadiusDirectional.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          const[
                            Image(
                              image: AssetImage('assets/images/female.png'),
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Female',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child:Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadiusDirectional.circular(10),

                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    const Text(
                      'HEIGHT',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children:
                      [
                       Text(
                         '${height.round()}',
                         style:const TextStyle(
                           fontSize: 40,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                       const Text(
                         'CM',
                         style: TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Slider(
                        value: height,
                        min: 80,
                        max: 200,
                        onChanged: (value)
                        {
                          setState(() {
                            height = value;
                          });
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children:
                [
                  Expanded(
                    child: Container(
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[400],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          const Text(
                            'WEIGHT',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                           Text(
                            '$weight',
                            style:const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              FloatingActionButton(
                                onPressed:()
                                {
                                  setState(() {
                                    weight--;
                                  });
                                },
                                mini: true,
                                heroTag: 'weight-',
                                child:const Icon(Icons.remove),
                              ),
                              FloatingActionButton(
                                onPressed:(){
                                  setState(() {
                                    weight++;
                                  });
                                },
                                mini: true,
                                heroTag: 'weight+',
                                child:const Icon(Icons.add),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[400],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          const Text(
                            'AGE',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                           Text(
                            '$age',
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              FloatingActionButton(
                                onPressed:(){
                                  setState(() {
                                    age--;
                                  });
                                },
                                mini: true,
                                heroTag: 'age-',
                                child:const Icon(Icons.remove),
                              ),
                              FloatingActionButton(
                                onPressed:(){
                                  setState(() {
                                    age++;
                                  });
                                },
                                mini: true,
                                heroTag: 'age+',
                                child:const Icon(Icons.add),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue,
            child: MaterialButton(
              onPressed: ()
              {
                double result = weight/ pow((height/100), 2);
                print(result.round());
                Navigator.push(
                  context,
                  MaterialPageRoute(builder:(context)=> BmiResult(
                    age: age,
                    result: result,
                    gender: isMale,
                  ) ,
                  ),
                );
              },
              child:const Text(
                'Calculate',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ) ,
            ),
          ),
        ],
      ),
    );
  }
}