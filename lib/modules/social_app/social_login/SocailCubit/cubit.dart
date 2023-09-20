import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/models/shop_app/login_model.dart';
import 'package:oneproject/modules/shop_app/shop_login/cubit/states.dart';
import 'package:oneproject/modules/social_app/social_login/SocailCubit/states.dart';
import 'package:oneproject/network/remote/dio_helper.dart';

import '../../../../network/end_points.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);



  void userLogin({
    required String email,
    required String password,
})
  {
    emit(SocialLoginLoadingState());
   FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email,
       password: password
   ).then((value){
     print(value.user!.uid);
     print(value.user!.email);
     emit(SocialLoginSuccessState(value.user!.uid));
   }).catchError((error){
     emit(SocialLoginErrorState(error.toString()));
   });
  }

  bool obscureText = true;

  IconData suffix =Icons.visibility_outlined;

  void changePasswordVisibility ()
  {
    obscureText = !obscureText;
    suffix = obscureText?Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialLoginChangePasswordState());
  }

}