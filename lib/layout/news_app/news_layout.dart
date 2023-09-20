// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:oneproject/layout/news_app/cubit/cubit.dart';
// import 'package:oneproject/layout/news_app/cubit/states.dart';
// import 'package:oneproject/network/remote/dio_helper.dart';
//
// class NewsLayout extends StatelessWidget {
//   const NewsLayout({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) =>NewsCubit()..getBusiness()..getSports()..getScience(),
//       child: BlocConsumer<NewsCubit,NewsStates>(
//         listener: (context,state){},
//         builder: (context,state)
//         {
//           var cubit = NewsCubit.get(context);
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('News App'),
//               actions:
//               [
//                 IconButton(
//                     onPressed: (){},
//                     icon:const Icon(Icons.search) ,
//                 ),
//                 IconButton(
//                     onPressed: ()
//                     {
//                       NewsCubit.get(context).changeAppMode();
//                     },
//                     icon:const Icon(Icons.brightness_2) ,
//                 ),
//               ],
//             ),
//             body: cubit.screens[cubit.currentIndex],
//
//             floatingActionButton: FloatingActionButton(
//               onPressed: ()
//               {
//                 NewsCubit.get(context).changeAppMode();
//               },
//               child: const Icon(Icons.add),
//             ),
//             bottomNavigationBar: BottomNavigationBar(
//               currentIndex: cubit.currentIndex,
//               onTap: (index)
//               {
//                 cubit.changeNavBar(index);
//               },
//               items:cubit.bottomsItem,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/layout/news_app/cubit/cubit.dart';
import 'package:oneproject/layout/news_app/cubit/states.dart';
import 'package:oneproject/modules/news_screens/search/search_screen.dart';
import 'package:oneproject/shared/components/components.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context)=> NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit , NewsStates>(
        listener: (context , state){},
        builder: (context , state)
        {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                  'News apps'
              ),
              actions:  [
                IconButton(
                    onPressed:()
                    {
                      navigateTo(context, SearchScreen(),);
                    },
                    icon:const Icon(Icons.search)),
                 IconButton(
                        onPressed:(){
                         cubit.changeAppMode();
                        },
                        icon:const Icon(Icons.dark_mode),
                 ),
              ]
            ),

            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (int index){
                cubit.changeNavBar(index);
              },
              items: cubit.bottomIcon,
            ),
          );
        },
      ),
    );
  }
}
