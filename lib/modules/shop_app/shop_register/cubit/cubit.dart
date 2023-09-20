import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneproject/models/shop_app/login_model.dart';
import 'package:oneproject/modules/shop_app/shop_login/cubit/states.dart';
import 'package:oneproject/modules/shop_app/shop_register/cubit/states.dart';
import 'package:oneproject/network/remote/dio_helper.dart';

import '../../../../network/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel?  registerModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
})
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name' : name,
          'email' : email,
          'password' : password,
          'phone' : phone,
        },
    ).then((value){
      print (value.data);
      registerModel = ShopLoginModel.fromJson(value.data);
      print(registerModel!.status);
      print(registerModel!.message);
      print(registerModel!.data?.token);
      emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error));
    });
  }

  bool obscureText = true;
  IconData suffix =Icons.visibility_outlined;

  void changePasswordVisibility ()
  {
    obscureText = !obscureText;
    suffix = obscureText?Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordState());
  }

}