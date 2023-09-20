// import 'package:bloc/bloc.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:oneproject/layout/news_app/cubit/states.dart';
// import 'package:oneproject/modules/business/business_screen.dart';
// import 'package:oneproject/modules/settings_screen/settings_screen.dart';
// import 'package:oneproject/modules/sports/sports_screen.dart';
//
// import '../../../modules/science/science_screen.dart';
// import '../../../network/remote/dio_helper.dart';

//class NewsCubit extends Cubit<NewsStates>
// {
//   NewsCubit () :super(NewsInitialStates());
//   static NewsCubit get(context) =>  BlocProvider.of(context);
//   int currentIndex = 0;
//   List<Widget> screens =
//   [
//     const BusinessScreen(),
//     const SportsScreen(),
//     const ScienceScreen(),
//   ];
//
//
//   List<BottomNavigationBarItem> bottomsItem =
//   [
//     const BottomNavigationBarItem(
//       icon: Icon(Icons.business),
//       label: 'Business'
//     ),
//     const BottomNavigationBarItem(
//       icon: Icon(Icons.sports),
//       label: 'Sports'
//     ),
//     const BottomNavigationBarItem(
//       icon: Icon(Icons.science),
//       label: 'science',
//     ),
//   ];
//   void changeNavBar( int index){
//     currentIndex = index;
//     if (index ==1){
//       getSports();
//     }
//     if (index ==2){
//       getScience();
//     }
//     emit(NewsBottomNavStates());
//   }
//
//   List<dynamic> business = [];
//   void getBusiness()
//   {
//     emit(NewsGetBusinessLoadingStates());
//     DioHelper.getData(
//         url: 'v2/top-headlines',
//         query:
//         {
//           'country':'eg',
//           'category':'business',
//           'apiKey':'74107c250d034d5e905c7d1993e05e7c',
//         }).then((value){
//       // print(value.data['articles'][0]['title']);
//       business = value.data['articles'];
//       print( business[0]['title']);
//       emit(NewsGetBusinessSuccessState());
//     }).catchError((error){
//       print(error.toString());
//       emit(NewsGetBusinessErrorState(error.toString()));
//     });
//   }
//
//   List<dynamic> sports = [];
//   void getSports() {
//     emit(NewsGetSportsLoadingStates());
//     if (sports.length == 0) {
//       DioHelper.getData(
//           url: 'v2/top-headlines',
//           query:
//           {
//             'country': 'eg',
//             'category': 'sports',
//             'apiKey': '74107c250d034d5e905c7d1993e05e7c',
//           }).then((value) {
//         sports = value.data['articles'];
//         print(sports[0]['title']);
//         emit(NewsGetSportsSuccessState());
//       }).catchError((error) {
//         print(error.toString());
//         emit(NewsGetSportsErrorState(error.toString()));
//       });
//     }
//     else {
//       emit(NewsGetSportsSuccessState());
//     }
//   }
//
//   List<dynamic> science = [];
//   void getScience()
//   {
//     emit(NewsGetScienceLoadingStates());
//     if(science.length ==0)
//     {
//       DioHelper.getData(
//           url: 'v2/top-headlines',
//           query:
//           {
//             'country':'eg',
//             'category':'science',
//             'apiKey':'74107c250d034d5e905c7d1993e05e7c',
//           }).then((value){
//         science = value.data['articles'];
//         print( science[0]['title']);
//         emit(NewsGetScienceSuccessState());
//       }).catchError((error){
//         print(error.toString());
//         emit(NewsGetScienceErrorState(error.toString()));
//       });
//     }
//     else
//     {
//       emit(NewsGetScienceSuccessState());
//     }
//
//   }
//
//   bool isDark = false;
//
//   void changeAppMode()
//   {
//     isDark = !isDark;
//
//     emit(AppChangeModeState());
//   }
//
//
//
//
//
//
// }

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/layout/news_app/cubit/states.dart';
import 'package:oneproject/modules/news_screens/search/business/business_screen.dart';
import 'package:oneproject/modules/news_screens/search/science/science_screen.dart';
import 'package:oneproject/modules/news_screens/search/sports/sports_screen.dart';
import 'package:oneproject/network/remote/cache_helper.dart';
import 'package:oneproject/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomIcon =
  [
   const BottomNavigationBarItem(
        icon: Icon(Icons.business),
      label: 'Business',
    ),

   const BottomNavigationBarItem(
        icon: Icon(Icons.science),
      label: 'Science',
    ),

   const BottomNavigationBarItem(
        icon: Icon(Icons.sports),
      label: 'Sports',
    ),
  ];

  void changeNavBar(int index)
  {
    currentIndex  = index;
    if (index == 1)
      getScience();
    if(index == 2)
      getSports();
    emit(NewsBottomNavState());
  }


  List<Widget> screens =
  [
    const BusinessScreen(),
    const ScienceScreen(),
    const SportsScreen()
  ];
  List<dynamic>  business =[];
  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'business',
          'apiKey':'74107c250d034d5e905c7d1993e05e7c',
        },
    ).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }


  List<dynamic>  sports =[];
  void getSports()
  {
    emit(NewsGetSportsLoadingState());
    if(sports.length == 0)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country':'eg',
            'category':'sports',
            'apiKey':'74107c250d034d5e905c7d1993e05e7c',
          },
        ).then((value) {
          sports = value.data['articles'];
          print(sports[0]['title']);
          emit(NewsGetSportsSuccessState());
        }).catchError((error)
        {
          print(error.toString());
          emit(NewsGetSportsErrorState(error.toString()));
        });
      }else{
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic>  science =[];
  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    if(science.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'Science',
          'apiKey':'74107c250d034d5e905c7d1993e05e7c',
        },
      ).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error)
      {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }
    else{
      emit(NewsGetScienceSuccessState());
    }

  }

  List<dynamic>  search = [];
  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query:
      {
        'q':'$value',
        'apiKey':'74107c250d034d5e905c7d1993e05e7c',
      },
    ).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });

  }


  bool isDark = false;

  void changeAppMode({bool? formShared})
  {
    if(formShared != null)
      {
        isDark = formShared;
      }else{
      isDark = !isDark;
    }
    CacheHelper.putData(key: 'isDark', value: isDark).then((value)
    {
      emit(AppChangeModeState());
    });
  }


}