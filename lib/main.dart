import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/layout/news_app/cubit/states.dart';
import 'package:oneproject/layout/news_app/news_layout.dart';
import 'package:oneproject/layout/social_app/cubit/social_cubit.dart';
import 'package:oneproject/layout/social_app/social_layout.dart';
import 'package:oneproject/layout/todo_app/todo_layout.dart';
import 'package:oneproject/modules/basics/counter/home/home_screen.dart';
import 'package:oneproject/modules/basics/counter/login/login_screen.dart';
import 'package:oneproject/modules/basics/counter/massenger/masengerScreen.dart';
import 'package:oneproject/modules/basics/counter/test/testdb.dart';
import 'package:oneproject/modules/basics/counter/user/user_screen.dart';
import 'package:oneproject/modules/shop_app/cubit/cubit.dart';
import 'package:oneproject/modules/shop_app/shop_login/cubit/cubit.dart';
import 'package:oneproject/modules/shop_app/shop_login/cubit/states.dart';
import 'package:oneproject/modules/shop_app/shop_login/login.dart';
import 'package:oneproject/network/remote/cache_helper.dart';
import 'package:oneproject/network/remote/dio_helper.dart';
import 'package:oneproject/shared/bloc_observer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:oneproject/shared/components/components.dart';
import 'package:oneproject/shared/components/constants.dart';
import 'package:oneproject/shared/styles/styles.dart';

import 'firebase_options.dart';
import 'layout/news_app/cubit/cubit.dart';
import 'layout/shop_app/shop_layout.dart';
import 'modules/shop_app/cubit/states.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'modules/social_app/social_login/social_login.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on background message');
  await Firebase.initializeApp();
  print(message.data.toString());

  showToast(text: 'on background message', state:ToastStates.SUCCESS);
}
void main()async {

  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();

   var token = await FirebaseMessaging.instance.getToken();
   print(token);
   FirebaseMessaging.onMessage.listen((event) {
     print('on message');
     print(event.data.toString());

     showToast(text: 'on message', state:ToastStates.SUCCESS);
   });

   FirebaseMessaging.onMessageOpenedApp.listen((event) {
     print('on message opened app');
     print(event.data.toString());

     showToast(text: 'on message opened app', state:ToastStates.SUCCESS);

   });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);



  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  Widget widget;
  // bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  // token = CacheHelper.getData(key: 'token');
  // print(token);

  // if(onBoarding != null)
  // {
  //   if(token != null)
  //   {
  //     widget = const ShopLayout();
  //   }else{
  //     widget = ShopLoginScreen();
  //   }
  // }else{
  //   widget = const OnBoardingScreen();
  // }
   uid = CacheHelper.getData(key: 'uid');
  if(uid != null){
    widget = const SocialLayout();
  }else{
    widget = SocialLoginScreen();
  }
  runApp(  MyApp(startWidget: widget,));

}

class MyApp extends StatelessWidget
{
  final Widget startWidget;
  const  MyApp( {super.key,required this.startWidget} );
  @override
  Widget build(BuildContext context)
  {
    return  MultiBlocProvider(
      providers:
      [
        BlocProvider(
            create: (context) =>  NewsCubit()..getBusiness(),
        ),
        BlocProvider(
            create: (context) =>  ShopLoginCubit(),
        ),
        BlocProvider(
            create: (context) =>  ShopCubit()..getHomeData()..getCategoryData()..getFavoriteData()..getSettingsData(),
        ),
        BlocProvider(
          create: (context) =>  SocialCubit()..getUserData()..getPostData(),
        ),

        BlocProvider(
          create: (BuildContext context) => NewsCubit()..changeAppMode(
  ),),
      ],
      child: MaterialApp(
        theme:  lightTheme,
        darkTheme: darkTheme,

        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner:false,
        home:startWidget,
      ),
    );
  }
}
