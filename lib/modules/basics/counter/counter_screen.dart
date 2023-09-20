import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';
class CounterScreen extends StatelessWidget {
  @override
  Widget  build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      //blocConsumer should understand it will work any(state and cubit)
      child: BlocConsumer<CounterCubit , CounterStates>(
        //listen when state act
        listener: (context , state){
          if(state is CounterMinusState) print( 'minis state + ${state.counter}');
          if(state is CounterPlusState) print( 'plus state + ${state.counter}');
        },
        builder: (context , state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title:const  Text('Counter'),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  TextButton(
                    onPressed: (){
                      CounterCubit.get(context).minus();
                    },
                    child:const Text(
                      'minis',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding:const  EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Text(
                      '${CounterCubit.get(context).counter}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                     CounterCubit.get(context).plus();
                    },
                    child:const Text(
                      'plus',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
