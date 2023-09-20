import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/models/social/social_user_model.dart';
import 'package:oneproject/modules/social_app/social_register/cubit/states.dart';
class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
})
  {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      print(value.user!.uid);
      userCreate(
          name: name,
          email: email,
          phone: phone,
          uid: value.user!.uid,
      );
      emit(SocialRegisterSuccessState());
    }).catchError((error){
      emit(SocialRegisterErrorState(error.toString()));
    });

  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uid,
})
{
  SocialUserModel model = SocialUserModel(
    name: name,
    email: email,
    phone: phone,
    uid: uid,
    cover: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHA38mcbYSwxkZBCqsidruQS_56L__hR7cuA&usqp=CAU',
    image: 'https://blog.hubspot.com/hs-fs/hubfs/website-design-list_0.webp?width=595&height=400&name=website-design-list_0.webp',
    bio: 'write your bios ',
    isEmailVerified: false,
  );
  FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .set(model.toMap())
      .then((value){
        emit(SocialCreateUserSuccessState());
  }).catchError((error){
    emit(SocialCreateUserErrorState(error.toString()));
  });
}

  bool obscureText = true;
  IconData suffix =Icons.visibility_outlined;

  void changePasswordVisibility ()
  {
    obscureText = !obscureText;
    suffix = obscureText?Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordState());
  }

}