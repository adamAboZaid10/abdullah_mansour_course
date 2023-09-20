import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/layout/social_app/cubit/social_state.dart';
import 'package:oneproject/modules/social_app/screens/post_screen/add_post_screen.dart';
import 'package:oneproject/modules/social_app/social_login/social_login.dart';
import 'package:oneproject/modules/social_app/social_register/register.dart';
import 'package:oneproject/shared/components/components.dart';

import 'cubit/social_cubit.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state)
      {
        if(state is SocialAddPostState)
        {
          navigateTo(context,  NewAddPost());
        }
      },
      builder: (context,state){
        var cubit = SocialCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title:  Text(cubit.titles[cubit.currentIndex]),
            actions:
            [
              IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_none)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
            ],
          ),
          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.changeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
            items:
            const [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.chat_sharp),label: 'Chats'),
              BottomNavigationBarItem(icon: Icon(Icons.add),label: 'post'),
              BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle),label: 'Users'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
//verified
// if(FirebaseAuth.instance.currentUser!.emailVerified)
//   Container(
//   color: Colors.amber.withOpacity(.6),
//   child: Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 20),
//     child: Row(
//       children:
//       [
//         const Icon(Icons.info_outline),
//         const SizedBox(width: 5,),
//         const Expanded(child:  Text('please verify your email')),
//         TextButton(
//             onPressed:()
//             {
//               FirebaseAuth.instance.currentUser!
//                   .sendEmailVerification()
//                   .then((value){
//                     showToast(text: 'check your email', state: ToastStates.SUCCESS);
//               })
//                   .catchError((error){});
//             },
//             child: const Text('SEND')),
//
//
//       ],
//     ),
//   ),
// ),
