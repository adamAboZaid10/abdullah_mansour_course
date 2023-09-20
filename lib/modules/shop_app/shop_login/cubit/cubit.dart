import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/models/shop_app/login_model.dart';
import 'package:oneproject/modules/shop_app/shop_login/cubit/states.dart';
import 'package:oneproject/network/remote/dio_helper.dart';

import '../../../../network/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel?  loginModel;

  void userLogin({
    required String email,
    required String password,
})
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email' : email,
          'password' : password,
        },
    ).then((value){
      print (value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel!.status);
      print(loginModel!.message);
      print(loginModel!.data?.token);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error));
    });
  }

  bool obscureText = true;
  IconData suffix =Icons.visibility_outlined;

  void changePasswordVisibility ()
  {
    obscureText = !obscureText;
    suffix = obscureText?Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopLoginChangePasswordState());
  }

}